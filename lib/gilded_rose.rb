class GildedRose
  attr_reader :name, :days_remaining, :quality

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  def tick
    if @name != "Aged Brie" and @name != "Backstage passes to a TAFKAL80ETC concert"
      if @quality > 0 && @name != "Sulfuras, Hand of Ragnaros"
        decrement_quality
      end
    elsif @quality < 50
      increment_quality
      if @name == "Backstage passes to a TAFKAL80ETC concert"
        if @days_remaining < 11 && @quality < 50
          increment_quality
        end
        if @days_remaining < 6 && @quality < 50
          increment_quality
        end
      end
    end
    if @name != "Sulfuras, Hand of Ragnaros"
      reduce_days_left
    end

    if @days_remaining < 0
      if @name != "Aged Brie"
        if @name != "Backstage passes to a TAFKAL80ETC concert"
          if @quality > 0 && @name != "Sulfuras, Hand of Ragnaros"
            decrement_quality
          end
        else
          expire_item
        end
      elsif @quality < 50
        increment_quality
      end
    end
  end

  private

  def increment_quality
    @quality = @quality + 1
  end

  def decrement_quality
    @quality = @quality - 1
  end

  def expire_item
    @quality = @quality - @quality
  end

  def reduce_days_left
    @days_remaining = @days_remaining - 1
  end

end
