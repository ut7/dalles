#!/usr/bin/env ruby
# encoding: utf-8

require 'sinatra'

CLEAR=`tput clear`

COLORS=(0..15).map { |c| `tput setaf #{c}` }

get '/' do
  erb :index
end

FILE = File.open('lecran', 'w+')

post '/update' do
  FILE.write " " * 20 * 4
  screen = (0..3).map do |y|
    (0..19).map do |x|
      key = "#{x}.#{y}"
      if params.keys.include?(key)
        COLORS[params[key.to_sym].to_i]+'█'
      else
        ' '
      end
    end
  end.flatten.join
  FILE.write CLEAR+screen
  FILE.flush
  'OK'
end


__END__

@@ index
<style>
body {
  background: black;
}
input {
  -webkit-appearance:none;
  width: 25px;
  height: 25px;
  margin: 0;
}
input[disabled] {
  background: grey;
}
</style>
<script src='//code.jquery.com/jquery-1.10.2.min.js'></script>
<script>
$(function() {
  var color = 15, htmlColor = '#fff';
  $('input:checkbox').click(function() {
    this.value = color;
    this.style.backgroundColor = htmlColor;
    this.checked = true;
    $.post('/update', $('form').serialize());
  });
  $('input:radio[name=color]').click(function() {
    color = this.value;
    htmlColor = $(this).data('color');
  });
});
</script>
<form action='/update' method='post'>
<% 
  4.times do |y|
    20.times do |x|
      %>
   <input type='checkbox' <%= "disabled" if x == 14 || x == 6 %>
    name="<%= x %>.<%= y %>" value="1" />
<% end %>
<br />
<%
  end
COLORMAP = [
  "#000000",
  "#bf7276",
  "#86af80",
  "#968a38",
  "#3673b5",
  "#9a70b2",
  "#7abecc",
  "#dbdbdb",
  "#6692af",
  "#e5505f",
  "#87bc87",
  "#e0d95c",
  "#1b85d6",
  "#ad73ba",
  "#338eaa",
  "#f4f4f4"
]

16.times do |c|
%>
  <input type='radio' name='color' value='<%= c %>'
    style='background-color:<%= COLORMAP[c] %>'
    data-color='<%= COLORMAP[c] %>'>
<%
end
%>
</form>

