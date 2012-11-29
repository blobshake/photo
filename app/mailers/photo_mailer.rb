class PhotoMailer < ActionMailer::Base
  default from: "from@example.com"
    
    def photo_email
        @url  = "http://example.com/login"
        mail(:to => "michaeldeverna@yahoo.com", :subject => "Welcome to My Awesome Site")
    end
end
