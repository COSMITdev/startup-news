module NewsHelper
  def host_for_link(url)
    URI(url).hostname.gsub(/\Awww\./, '')
  end
end
