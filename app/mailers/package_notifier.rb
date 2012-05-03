class PackageNotifier < ActionMailer::Base
  default :from => "berkeley.beartracks@gmail.com"
  
  def package_notification(package)
    @package = package
    @resident = @package.resident 
    mail(:to => @resident.email, :subject => "You have a package waiting for you!")
  end
  
end
