# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    when /^the clerks? page$/
      '/clerks'
    when /^the clerk edit page for (.*)$/
      "/clerks/#{Clerk.find_by_login($1).id}/edit"
    when /^the clerk show page for (.*)$/
      "/clerks/#{Clerk.find_by_login($1).id}"
    when /^the clerk home page$/
      "/packages"

    when /^the packages? page$/
      '/packages'
    when /^the add\s?-?package page$/
      '/packages/new'
    when /^the package details page for package ([0-9]+)$/
      "/packages/#{$1}"
    when /^the edit package page for package ([0-9]+)$/
      "/packages/#{$1}/edit"

    when /^the resident edit page for resident ([0-9]+)$/
      "/residents/#{$1}/edit"
    when /^the resident show page for resident ([0-9]+)$/
      "/residents/#{$1}"


    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
