class Car < ActiveRecord::Base
  belongs_to :model

  enum :currency => {clp: 0, clf: 1, usd: 2}

  validates :model, :year, :price, :image, :quantity, presence: true
  validates :year, numericality: { only_integer: true, greater_than: 1900, less_than: 2100 }
  validates :price, numericality: { only_integer: true, greater_than: 0 }
  validates :quantity, numericality: { only_integer: true }

  scope :more_important_first, -> { order(id: :desc) }
  scope :not_in, ->(*ignore_list) { where.not(id: ignore_list) }

  def self.limited_related_ids(id,candidates,limit)
    more_important_first.not_in(candidates).not_in([id]).limit(limit).ids
  end

  def brand_name
    model.try(:brand_name)
  end
  def brand_id
    model.try(:brand_id)
  end

  def car_model_name
    model.try(:name)
  end

  def make_id
    model.try(:make_id)
  end

  def related(howmany = 5)
    # buscaremos hasta conseguir una cantidad
    # mayor o igual a la deseada y hasta 2x
    # la cantidad deseada, para poder dar algo
    # de aletoreidad
    limit = howmany * 2

    # primero mismo modelo
    candidates = model.cars.limited_related_ids(id, [], limit)

    # otros modelos de la misma marca si no tenemos el maximo deseado
    if candidates.length < limit
      # actualizamos el limite
      limit = limit - candidates.length
      candidates.concat Car.joins(:model).where(models: {brand_id: brand_id}).limited_related_ids(id, candidates, limit)

    end

    # hasta aqui agregamos pensando en el limite superior
    # ahora la forma de rellenar es fea: autos random
    # asi que aqui solo exigiremos que haya el minimo
    if candidates.length < howmany
      limit = howmany - candidates.length # estos son los faltantes
      candidates.concat Car.limited_related_ids(id, candidates, limit)
    end

    # ahora sacamos los ids con que nos quedaremos y obtenemos los autos en si
    # revolvemos
    candidates.shuffle!
    Car.where(id: candidates[0...howmany]).more_important_first
  end

  # ############################################################
  # ### Lo que sigue es para manejar la imagen
  # ### (guardado, thumb, eliminado, etc)
  # ### sin la necesidad de una gema ni otro codigo externo
  # ############################################################

  attr_accessor :saving_image_file

  after_save :save_image_file
  after_destroy :destroy_image_file

  def image
    image_file_name
  end

  def image=(new_image)
    if new_image.present?
      # two options supported: via form data or as json object
      if new_image.respond_to?(:original_filename)
        self.image_file_name = new_image.original_filename
        self.saving_image_file = new_image
      elsif new_image.is_a?(Hash) && new_image.has_key?(:original_filename) && new_image.has_key?(:base64_data)
        self.image_file_name = new_image[:original_filename]
        base64_data = new_image[:base64_data]
        new_tempfile = Tempfile.new(image_file_name)
        # if should starts with data:image/jpeg;base64, - remove it!
        binary = Base64.decode64( base64_data.sub('data:image/jpeg;base64,','') )
        binary.force_encoding('UTF-8')
        new_tempfile.write binary
        new_tempfile.close
        new_tempfile.open
        self.saving_image_file = new_tempfile
      end

    else
      self.image_file_name = nil
      self.saving_image_file = nil
    end
  end


  def image_path(type = :original)
    if new_record?
      return nil
    end
    "#{Rails.root}/public#{image_url(type)}"
  end

  def image_url(type = :small)
    if new_record?
      return nil
    end

    type_s = case type
    when :small
      'sm'
    else
      'original'
    end

    '/system/cars/images/%03d/%s/%03d-%s' % [id / 1000, type_s, id % 1000, image_file_name]
  end

  private

  def save_image_file
    if saving_image_file.present?
      File.open(image_path, 'wb') do |file|
        file.write(saving_image_file.read)
      end
      # copy first, so if resize file, at least will have
      # original file as thumb
      FileUtils.cp image_path, image_path(:small)
      # here I should trying using image magick to resize image file
      # ignoring on failure
      begin
        image_path = image_path(:small).gsub('"','\\"')
        `convert "#{image_path}" -resize 600x200\\> "#{image_path}"`
      rescue
      end
    end
  end

  def destroy_image_file
    FileUtils.rm_f image_path
    FileUtils.rm_f image_path(:small)
  end

end
