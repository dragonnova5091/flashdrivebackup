class Item
  attr_reader :name, :type, :attribute
  def initialize(type, tier)
    @type = type
    # type = 1: 'sword', 2: 'armor', 3: 'potion'
    if tier == 0
      tier = rand(1..3)
    end
    # Valid items are "weapon", "armor", "potion"
    @mods = ["", "wooden  weak".split("  "), "iron  average".split("  "), "stainless steel  strong".split("  ")]
    case @type
    when 1
      @attribute = [rand(tier * 2..rand(tier * 4..tier * 6)), "dmg"]
      @name = @mods[tier][0] + " sword"
    when 2
      @attribute = [rand(tier * 3..rand(tier * 4..tier * 10)), 'def']
      @name = @mods[tier][0] + " armor"
    when 3
      @attribute = [rand(tier * 10..rand(tier * 10..tier * 15)), 'hp']
      @name = @mods[tier][1] + " potion"
    end
  end
end