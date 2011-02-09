#!/usr/bin/env ruby

require "tempfile"
require "fileutils"
require "nokogiri"

%x{cp -r ../forkmerge-prototype/ ../deployable}
%x{cp index.php ../deployable/}
%x{cp favicon.ico ../deployable/}
%x{rm ../deployable/index.html ../deployable/README.txt}
%x{cp bg_milimeter.png ../deployable/}


Dir['../deployable/**/*html'].each do |filename|
  puts filename

  temp = Tempfile.new('transform')
  
  # f = File.open(filename)
  # doc = Nokogiri::HTML(f)
  # f.close
  # 
  # # Replace Title
  # doc.xpath('//head/title').each do |title| 
  #     title.content = title.content.gsub(/pidoco - Prototype Test/, 'ForkMerge') 
  # end
  # 
  # # Replace favicon with your own
  # doc.xpath('//head/link[@rel="shortcut icon"]').each do |favi_link|      
  #   favi_link['href'] = "../favicon.ico" 
  # end
  # 
  # doc.css('.svg_border path').each do |path|      
  #   path['style'] += "fill: #fcf6de;" 
  # end
  # doc.root.remove_attribute('xmlns')
  # temp << doc.to_xml


  File.foreach(filename) do |line|
    line = line.gsub(/pidoco - Prototype Test/, 'ForkMerge')
    line = line.gsub(/https:\/\/pidoco.com\/files\/icons\/favicon.ico/, '../favicon.ico')
    temp << line
  end
  
  temp.close
  FileUtils.mv(temp.path, filename)

end
  
  File.open("../deployable/resources/css/sketched.css", "a") << '
html, body {
  background: transparent repeat url(../../bg_milimeter.png)
}
.svg_border .svg_unselected_element {display:none}
#borderDiv {
  background-color:white;

  -webkit-border-radius: 5px;
  -moz-border-radius: 5px;
  border-radius: 5px;
  -moz-box-shadow: 0 3px 4px #999;
  -webkit-box-shadow: 0 3px 4px #999;
  position: relative;
  background: white;
  height: 100%;
  min-height: 700px;
  border-top-left-radius: 5px 5px;
  border-top-right-radius: 5px 5px;
  border-bottom-right-radius: 5px 5px;
  border-bottom-left-radius: 5px 5px;
}'

