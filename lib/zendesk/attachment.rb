module Zendesk
  module Attachment

    def upload_attachment(body={})
      make_request("uploads", :upload => body) if [:file, :filename].all?{|key| body.include?(key) }
    end

  end
end
