class GildedRose
  attr_reader :name, :days_remaining, :quality

  AGED_BRIE = "Aged Brie"
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
  SULFURAS = "Sulfuras, Hand of Ragnaros"

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  def tick
    # reduce item quality on non-special items
    if @name != AGED_BRIE and @name != BACKSTAGE_PASSES
      if @quality > 0 && @name != SULFURAS
        decrease_quality
      end
    # increase item quality (value) on special items
    elsif @quality < 50
      increase_quality
      # backstage passes have increased value based on days
      # remaining to concert
      if @name == BACKSTAGE_PASSES
        if @days_remaining <= 10 && @quality < 50
          increase_quality
        end
        if @days_remaining <= 5 && @quality < 50
          increase_quality
        end
      end
    end

    # reduce time left for items other than sulfuras
    if @name != SULFURAS
      reduce_days_left
    end

    # expired items lose more quality until junk
    if @days_remaining < 0
      special_items_list = [SULFURAS, BACKSTAGE_PASSES, AGED_BRIE]
      if @quality > 0 && !special_items_list.include?(@name)
        decrease_quality
      end

      # passes become immediately junk after concert has passed
      if @name == BACKSTAGE_PASSES
        invalidate_item
      end

      # cheese improves with age
      if @name == AGED_BRIE && @quality < 50
        increase_quality
      end
    end
  end

  private

  def increase_quality
    @quality = @quality + 1
  end

  def decrease_quality
    @quality = @quality - 1
  end

  def invalidate_item
    @quality = @quality - @quality
  end

  def reduce_days_left
    @days_remaining = @days_remaining - 1
  end

end
