require "test_helper"

class HelperTest < ActionView::TestCase
  tests Webpacker::Helper

  def test_asset_pack_path
    assert_equal "/packs/bootstrap-300631c4f0e0f9c865bc.js", asset_pack_path("bootstrap.js")
    assert_equal "/packs/bootstrap-c38deda30895059837cf.css", asset_pack_path("bootstrap.css")
  end

  def test_image_pack_path
    assert_equal "/packs/application-k344a6d59eef8632c9d1.png", image_pack_path("application.png")
    assert_equal "/packs/media/images/image-c38deda30895059837cf.jpg", image_pack_path("image.jpg")
    assert_equal "/packs/media/images/image-c38deda30895059837cf.jpg", image_pack_path("media/images/image.jpg")
    assert_equal "/packs/media/images/nested/image-c38deda30895059837cf.jpg", image_pack_path("nested/image.jpg")
    assert_equal "/packs/media/images/nested/image-c38deda30895059837cf.jpg", image_pack_path("media/images/nested/image.jpg")
  end

  def test_image_pack_tag
    assert_equal \
      "<img alt=\"Edit Entry\" height=\"10\" src=\"/packs/application-k344a6d59eef8632c9d1.png\" width=\"16\" />",
      image_pack_tag("application.png", size: "16x10", alt: "Edit Entry")
    assert_equal \
      "<img alt=\"Edit Entry\" height=\"10\" src=\"/packs/media/images/image-c38deda30895059837cf.jpg\" width=\"16\" />",
      image_pack_tag("image.jpg", size: "16x10", alt: "Edit Entry")
    assert_equal \
      "<img alt=\"Edit Entry\" height=\"10\" src=\"/packs/media/images/image-c38deda30895059837cf.jpg\" width=\"16\" />",
      image_pack_tag("media/images/image.jpg", size: "16x10", alt: "Edit Entry")
    assert_equal \
      "<img alt=\"Edit Entry\" height=\"10\" src=\"/packs/media/images/nested/image-c38deda30895059837cf.jpg\" width=\"16\" />",
      image_pack_tag("nested/image.jpg", size: "16x10", alt: "Edit Entry")
    assert_equal \
      "<img alt=\"Edit Entry\" height=\"10\" src=\"/packs/media/images/nested/image-c38deda30895059837cf.jpg\" width=\"16\" />",
      image_pack_tag("media/images/nested/image.jpg", size: "16x10", alt: "Edit Entry")
    assert_equal \
      "<img alt=\"Image-c38deda30895059837cf\" src=\"/packs/media/images/image-c38deda30895059837cf.jpg\" srcset=\"/packs/media/images/image-2x-7cca48e6cae66ec07b8e.jpg 2x\" />",
      image_pack_tag("media/images/image.jpg", srcset: { "media/images/image-2x.jpg" => "2x" })
  end

  def test_favicon_pack_tag
    assert_equal \
      "<link href=\"/packs/application-k344a6d59eef8632c9d1.png\" rel=\"apple-touch-icon\" type=\"image/png\" />",
      favicon_pack_tag("application.png", rel: "apple-touch-icon", type: "image/png")
    assert_equal \
      "<link href=\"/packs/media/images/mb-icon-c38deda30895059837cf.png\" rel=\"apple-touch-icon\" type=\"image/png\" />",
      favicon_pack_tag("mb-icon.png", rel: "apple-touch-icon", type: "image/png")
    assert_equal \
      "<link href=\"/packs/media/images/mb-icon-c38deda30895059837cf.png\" rel=\"apple-touch-icon\" type=\"image/png\" />",
      favicon_pack_tag("media/images/mb-icon.png", rel: "apple-touch-icon", type: "image/png")
    assert_equal \
      "<link href=\"/packs/media/images/nested/mb-icon-c38deda30895059837cf.png\" rel=\"apple-touch-icon\" type=\"image/png\" />",
      favicon_pack_tag("nested/mb-icon.png", rel: "apple-touch-icon", type: "image/png")
    assert_equal \
      "<link href=\"/packs/media/images/nested/mb-icon-c38deda30895059837cf.png\" rel=\"apple-touch-icon\" type=\"image/png\" />",
      favicon_pack_tag("media/images/nested/mb-icon.png", rel: "apple-touch-icon", type: "image/png")
  end

  def test_preload_pack_asset
    if self.class.method_defined?(:preload_link_tag)
      assert_equal \
        %(<link rel="preload" href="/packs/fonts/fa-regular-400-944fb546bd7018b07190a32244f67dc9.woff2" as="font" type="font/woff2" crossorigin="anonymous">),
        preload_pack_asset("fonts/fa-regular-400.woff2")
    else
      error = assert_raises do
        preload_pack_asset("fonts/fa-regular-400.woff2")
      end

      assert_equal \
        "You need Rails >= 5.2 to use this tag.",
        error.message
    end
  end

  def test_javascript_pack_tag
    assert_equal \
      %(<script src="/packs/vendors~application~bootstrap-c20632e7baf2c81200d3.chunk.js" type="text/javascript"></script>\n) +
        %(<script src="/packs/vendors~application-e55f2aae30c07fb6d82a.chunk.js" type="text/javascript"></script>\n) +
        %(<script src="/packs/application-k344a6d59eef8632c9d1.js" type="text/javascript"></script>\n) +
        %(<script src="/packs/bootstrap-300631c4f0e0f9c865bc.js" type="text/javascript"></script>),
      javascript_pack_tag("application", "bootstrap")
  end

  def test_javascript_pack_tag_splat
    assert_equal \
      %(<script defer="defer" src="/packs/vendors~application~bootstrap-c20632e7baf2c81200d3.chunk.js" type="text/javascript"></script>\n) +
        %(<script defer="defer" src="/packs/vendors~application-e55f2aae30c07fb6d82a.chunk.js" type="text/javascript"></script>\n) +
        %(<script defer="defer" src="/packs/application-k344a6d59eef8632c9d1.js" type="text/javascript"></script>),
      javascript_pack_tag("application", defer: true)
  end

  def test_javascript_pack_tag_symbol
    assert_equal \
      %(<script src="/packs/vendors~application~bootstrap-c20632e7baf2c81200d3.chunk.js" type="text/javascript"></script>\n) +
        %(<script src="/packs/vendors~application-e55f2aae30c07fb6d82a.chunk.js" type="text/javascript"></script>\n) +
        %(<script src="/packs/application-k344a6d59eef8632c9d1.js" type="text/javascript"></script>),
      javascript_pack_tag(:application)
  end

  def test_stylesheet_pack_tag
    assert_equal \
      %(<link href="/packs/1-c20632e7baf2c81200d3.chunk.css" media="screen" rel="stylesheet" type="text/css" />\n) +
        %(<link href="/packs/application-k344a6d59eef8632c9d1.chunk.css" media="screen" rel="stylesheet" type="text/css" />\n) +
        %(<link href="/packs/hello_stimulus-k344a6d59eef8632c9d1.chunk.css" media="screen" rel="stylesheet" type="text/css" />),
      stylesheet_pack_tag("application", "hello_stimulus")
  end

  def test_stylesheet_pack_tag_symbol
    assert_equal \
      %(<link href="/packs/1-c20632e7baf2c81200d3.chunk.css" media="screen" rel="stylesheet" type="text/css" />\n) +
        %(<link href="/packs/application-k344a6d59eef8632c9d1.chunk.css" media="screen" rel="stylesheet" type="text/css" />\n) +
        %(<link href="/packs/hello_stimulus-k344a6d59eef8632c9d1.chunk.css" media="screen" rel="stylesheet" type="text/css" />),
      stylesheet_pack_tag(:application, :hello_stimulus)
  end

  def test_stylesheet_pack_tag_splat
    assert_equal \
      %(<link href="/packs/1-c20632e7baf2c81200d3.chunk.css" media="all" rel="stylesheet" type="text/css" />\n) +
        %(<link href="/packs/application-k344a6d59eef8632c9d1.chunk.css" media="all" rel="stylesheet" type="text/css" />),
      stylesheet_pack_tag("application", media: "all")
  end
end
