##PACKAGES##
Given /the following packages? exists? my\s?way:/i do |package_table|
  package_table.hashes.each do |package|
    Package.create(package)
  end
end


