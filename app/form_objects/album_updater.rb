# frozen_string_literal: true

class AlbumUpdater
  def initialize(album)
    @album = album
  end

  def update(attributes)
    @album.update(album_attributes(attributes))
    fun_fact = @album.fun_fact || @album.build_fun_fact
    fun_fact.update(fun_fact_attributes(attributes))
    @album
  end

  def album_attributes(attributes)
    attributes.except(:fun_fact_description, :fun_fact_source)
  end

  def fun_fact_attributes(attributes)
    attrs = attributes.slice(:fun_fact_description, :fun_fact_source)
    {
      description: attrs[:fun_fact_description],
      source: attrs[:fun_fact_source]
    }
  end

  def resource
    album
  end

  private

  attr_reader :album
end
