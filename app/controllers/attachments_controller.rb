class AttachmentsController < ApplicationController
  def index
    @attachments = Attachment.all
  end

  def show
    @attachment = Attachment.find(params[:id])
    send_data(@attachment.data,
           type: @attachment.mime_type,
           filename: @attachment.filename)
  end

  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = Attachment.new(attachment_params) do |t|
      if params[:attachment][:data]
        t.data      = params[:attachment][:data].read
        t.filename  = params[:attachment][:data].original_filename
        t.mime_type = params[:attachment][:data].content_type
      end
    end

    if @attachment.save
      redirect_to(attachments_path, :notice => 'attachment was successfully created.')
    else
      render :action => "new"
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    redirect_to(attachments_url)
  end

  def serve
     # @attachment = Attachment.find(params[:id])
     # send_data(@attachment.data, :type => @attachment.mime_type, :filename => "#{@attachment.name}", :disposition => "inline")
   end

   private
   # Use callbacks to share common setup or constraints between actions.
   def set_attachment
     @attachment = Attachment.find(params[:id])
   end

   # Never trust parameters from the scary internet, only allow the white list through.
   def attachment_params
     params.require(:attachment).permit(:name, :data, :filename, :mime_type)
   end
end
