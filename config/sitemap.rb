SitemapGenerator::Sitemap.default_host = 'http://www.kauntaa.com'
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new
SitemapGenerator::Sitemap.sitemaps_host = "http://#{ENV['FOG_DIRECTORY']}.s3.amazonaws.com/"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.create do
  # Root
  add '/', changefreq: 'daily', priority: 1.0

  # Pages
  add '/pages/about', changefreq: 'daily', priority: 0.9
end
