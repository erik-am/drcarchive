def transcript
  output = yield
  
  output = output.gsub(/(^|<p>)(\([0-9][0-9][^)]+\)  *)*(([^\(]|\([^I])[^\:]+ \(I'm on the surface, be back in a minute\)\:)/, "")
  output = output.gsub(/(^|<p>)(\([0-9][0-9][^)]+\)  *)*(([^\(]|\([^I])[^\:]+ \(Ich bin an der Oberfläche, komme gleich zurück\)\:)/, "")
  output = output.gsub(/(^|<p>)(\([0-9][0-9][^)]+\)  *)*(([^\(]|\([^J])[^\:]+ \(Je suis à la surface. Je serai de retour dans une minute\)\:)/, "")
  
  if !@item[:highlight].nil?
  	@item[:highlight].length.times do |i|
	  output = output.gsub(/(^|<p>)(\([0-9][0-9][^)]+\)  *)*((From )*#{@item[:highlight][i]}( in [^\:]+)*\:)(.*$)/, "<div class=\"transcript-highlight-#{i+1}\"><div class=\"transcript-name\">\\3</div>\\6</div>")
	  output = output.gsub(/(^|<p>)(\([0-9][0-9][^)]+\)  *)*((To )*#{@item[:highlight][i]}( in [^\:]+)*\:)(.*$)/, "<div class=\"transcript-no-highlight\"><div class=\"transcript-name\">\\3</div>\\6</div>")
	  output = output.gsub(/(^|<p>)(\([0-9][0-9][^)]+\)  *)*(#{@item[:highlight][i]} .+$)/, "<div class=\"transcript-highlight-#{i+1}\"><div class=\"transcript-name\">\\3</div></div>")
	end
  end
  
  output = output.gsub(/(^|<p>)(\([0-9][0-9][^)]+\) )*((From )[^\:]+\:)(.*$)/, "")
  output = output.gsub(/(^|<p>)(\([0-9][0-9][^)]+\) )*((To )[^\:]+\:)(.*$)/, "")
  
  output = output.gsub(/([\r\n])[\r\n]+/,"\\1")
  
  output = output.gsub(/(^|<p>)(\([0-9][0-9][^)]+\)  *)*(((?!\[Note\:)[^\:])+\:) (.*$)/, "<div class=\"transcript-no-highlight\"><div class=\"transcript-name\">\\3</div> \\5</div>")
  output = output.gsub(/(^|<p>)(\([0-9][0-9][^)]+\)  *)*([^\s]((?!\:<\/div>)(?!Note\:).)+$)/, "<div class=\"transcript-no-highlight\"><div class=\"transcript-name\">\\3</div></div>")
  output = output.gsub(/(^|<p>)\[Note\: ([^\]]+)\]$/,"<p>[\\2]</p>")
  output
end