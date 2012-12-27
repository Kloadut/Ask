Ask.controllers :req do
    get :index, :map => "/" do
        render 'index'
    end

    get "/new/raw" do
        captcha_create
        render 'req/new.raw', :layout => false
    end

    get "/list/raw" do
        if params["tags"] && params["type"]
            tags = params["tags"].split(",").each {|t| t.strip!}
            @reqs = Req.where(:tags => tags, :type => params["type"]).fields(:title, :author_nick, :created_at).limit(5).sort(:created_at.desc)
            return render 'req/list.raw', :layout => false if @reqs.count > 0
        end
        'No result found'
    end

    get :tags, :map => "/tags" do
        array = []
        Req.fields(:tags).all.each { |r| r.tags.each { |t| array.push(t) } }
        array.uniq!.to_json
    end

    post :new do
        captcha_validate
        logger.info params

        # delete "image" params entry
        image = params["image"]
        params.delete("image")

        # split tags
        params["tags"] = params["tags"].split(",").each {|t| t.strip!}

        logger.info params
        @req = Req.new(params)

        if image
            redirect url(:req, :index) unless @req.save_image(image)
        end


        if @req.save
            flash[:notice] = "Your request has been successfully published"
        else
            flash[:warning] = "An error occured during request creation: " + @req.errors.full_messages
        end
        redirect url(:req, :index)
    end

    get :show, :with => :id do
        @req = Req.find(params[:id])
        @comments = @req.comments
        captcha_create
        render 'req/show'
    end

    post :comment do
        captcha_validate
        @req =  Req.find(params[:req_id])
        if !@req.nil?
            c = @req.comments.create(:nick => params[:nick], :body => params[:body])
            if c.valid?
                @req.save
                flash[:notice] = t "Your comment has been posted"
            else
                flash[:warning] = t "Your comment hasn't been posted:<br />#{c.errors.full_messages}"
            end
            redirect url(:req, :show, :id => params[:req_id])
        else
            flash[:warning] =  "The request you are trying to comment doesn't exist"
        end
        redirect url(:req, :index)
    end
end
