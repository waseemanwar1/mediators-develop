module DefaultMethods
  extend ActiveSupport::Concern

  included do
    def create
      create! do |success, failure|
        success.html do
          flash[:notice] = "#{t(resource_class.name.underscore.to_sym)} #{t('admin.component.alerts.successfull.create')}"
          redirect_to collection_url
        end
        failure.html do
          flash[:errors] = resource.errors.full_messages
          render :new
        end
      end
    end

    def update
      update! do |success, failure|
        success.html do
          flash[:notice] = "#{t(resource_class.name.underscore.to_sym)} #{t('admin.component.alerts.successfull.update')}"
          redirect_to collection_url
        end
        failure.html do
          flash[:errors] = resource.errors.full_messages
          render :edit
        end
      end
    end

    def destroy
      destroy! do |success, failure|
        success.html do
          flash[:notice] = "#{t(resource_class.name.underscore.to_sym)} #{t('admin.component.alerts.successfull.destroy')}"
          redirect_to collection_url
        end
        failure.html do
          flash[:errors] = resource.errors.full_messages
          redirect_to collection_url
        end
      end
    end

    def search
      if params[:elasticsearch] == "true"
        search = Search.new(
          model: resource_class,
          params: params,
        )
        collection = search.collection
      else
        collection = resource_class.all.order(id: :desc).page(params[:page])
      end
      respond_to do |format|
        format.html { render partial: "search", locals: { items: collection } }
      end
    end
  end
end
