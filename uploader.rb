require "bundler/inline"
require "fileutils"
require "optparse"

gemfile do
  source "https://rubygems.org"
  gem "sinatra", require: "sinatra/base"
  gem "sinatra-flash", require: "sinatra/flash"
end

options = {}

OptionParser.new do |op|
  op.on "-p", "--port NUMBER", Integer do |v|
    options[:port] = v
  end
end.parse!(ARGV)

Class.new(Sinatra::Base) do
  TEMPLATE = DATA.read

  set :port, options[:port] if options[:port]

  enable :sessions
  register Sinatra::Flash

  get "/" do
    erb TEMPLATE
  end

  FileUtils.mkdir_p(public_folder)

  post "/upload" do
    name = params[:file][:filename]
    file = params[:file][:tempfile]

    path = File.join(self.class.public_folder, name)
    File.open(path, "wb") do |f|
      f.write(file.read)
    end

    flash[:notice] = "Uploaded to #{path}"
    redirect "/"
  end
end.run!

__END__
<!DOCTYPE html>
<html style="padding: 0; margin: 0">
  <head>
    <meta charset="UTF-8">
    <title><%= File.basename(__FILE__, ".rb") %></title>
  </head>
  <body style="padding: 0; margin: 0">
    <% if flash[:notice] %>
      <p style="margin: 0; padding: 1ex; color: white; background-color: green"><%= flash[:notice] %></p>
    <% end %>
    <form action="/upload" method="post" enctype="multipart/form-data" style="padding: 1ex">
      <input type="file" name="file">
      <input type="submit" value="upload">
    </form>
  </body>
</html>
