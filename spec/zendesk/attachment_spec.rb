require "spec"
require 'lib/zendesk-api'

describe Zendesk::Attachment do
  before do
    curl_object = Curl::Easy.method(:new)
    Curl::Easy.stub!(:new).and_return do |*args|
      curl = curl_object.call(*args)
      curl.should_receive(:http_post).with(an_instance_of(Curl::PostField))
      curl
    end
  end

  context "#upload_attachment" do
    it "should be able to create" do
        zendesk = Zendesk::Main.new('my_company', "some_login", "some_password")
        params = {
          :filename => "some_file.jpg",
          :file => "A File"
        }
        response = zendesk.upload_attachment(params)
        response.url.should =~ /filename=some_file.jpg/
    end

    it "should be able to batch create" do
        zendesk = Zendesk::Main.new('my_company', "some_login", "some_password")
        params = {
          :filename => "some_file.jpg",
          :file => "A File",
          :token => "sometoken"
        }
        response = zendesk.upload_attachment(params)
        response.url.should =~ /token=sometoken/
    end
  end

end
