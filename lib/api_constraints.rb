class ApiConstraints
  def initialize(version)
    @version = version
  end
 
  def matches?(request)
    versioned_accept_header?(request) || default?(request)
  end
 
  private
 
  def versioned_accept_header?(request)
    accept = request.headers['Accept']
    if accept
      mime_type, version = accept.gsub(/\s/, "").split(";")
      mime_type, format = mime_type.split("+")
      version = version.split("=").pop.to_i unless version.nil?
      mime_type.match(/#{API_HEADER}/) && version == @version
    end
  end

  def unversioned_accept_header?(request)
    accept = request.headers['Accept']

    if accept
      mime_type, version = accept.gsub(/\s/, "").split(";")
      mime_type, format = mime_type.split("+")
      version = version.split("=").pop.to_i  unless version.nil?
      !mime_type.match(/#{API_HEADER}/) && version.to_i != @version
    end
  end

  def default?(request)
    @version == API_DEFAULT && unversioned_accept_header?(request)
  end
end