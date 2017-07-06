#

require 'tk'
def hi
	puts "HI!!!!!!"
end
def printheight
  num = $scale.get()
  puts num
end

root = TkRoot.new { title "HI"}

entry1 = TkEntry.new(root)
entry1.place('height' => 40,
            'width'  => 100,
            'x'      => 10,
            'y'      => 45)
$scale = entry1

$scale = TkScale.new(root) do
	orient 'horizontal'
	length 130
	from 0
	to 100
	command (proc {printheight})
	tickinterval 50
	pack
end

btn_OK = TkButton.new(root) do
  text "Hi"
  borderwidth 5
  underline 0
  state "normal"
  cursor "watch"
  font TkFont.new('times 11')
  foreground  "red"
  activebackground "blue"
  relief      "groove"
  command (proc {hi})
  pack("side" => "right",  "padx"=> "10", "pady"=> "10")
end
Tk.mainloop