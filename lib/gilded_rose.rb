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
    if @name != AGED_BRIE and @name != BACKSTAGE_PASSES
      if @quality > 0 && @name != SULFURAS
        decrease_quality
      end
    elsif @quality < 50
      increase_quality
      if @name == BACKSTAGE_PASSES
        if @days_remaining < 11 && @quality < 50
          increase_quality
        end
        if @days_remaining < 6 && @quality < 50
          increase_quality
        end
      end
    end
    if @name != SULFURAS
      reduce_days_left
    end

    if @days_remaining < 0
      # if @name != AGED_BRIE
      #   if @name != BACKSTAGE_PASSES
          # if @quality > 0 && @name != SULFURAS
          #   decrease_quality
          # end
        # else
        #   expire_item
        # end
      # elsif @quality < 50
      #   increase_quality
      # end

      special_items_list = [SULFURAS, BACKSTAGE_PASSES, AGED_BRIE]
      if @quality > 0 && !special_items_list.include?(@name)
        decrease_quality
      end

      if @name == BACKSTAGE_PASSES
        expire_item
      end

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

  def expire_item
    @quality = @quality - @quality
  end

  def reduce_days_left
    @days_remaining = @days_remaining - 1
  end

end
