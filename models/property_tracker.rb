require('pg')

class PropertyTracker

  attr_accessor :address, :value, :number_of_bedrooms, :year_built
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @address = options['address']
    @value = options['value']
    @number_of_bedrooms = options['number_of_bedrooms']
    @year_built = options['year_built']

  end

  def save
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'});
    sql = "INSERT INTO properties(address,value,number_of_bedrooms,year_built) VALUES ($1, $2, $3, $4) RETURNING id;"
    values = [@address, @value, @number_of_bedrooms, @year_built]
    db.prepare("save",sql)
    prop_hashes = db.exec_prepared("save",values)
    @id = prop_hashes[0]['id']
    db.close
  end

  def update
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'});
    sql = "UPDATE properties SET(address,value,number_of_bedrooms,year_built) = ($1,$2,$3,$4) WHERE id = $5;"
    values = [@address, @value, @number_of_bedrooms, @year_built, @id]
    db.prepare("update", sql)
    prop_hashes = db.exec_prepared("update",values)
    db.close

  end

  def PropertyTracker.delete_all
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'});
    sql = "DELETE FROM properties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close

  end

  def PropertyTracker.find(ident)
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'});
    sql = "SELECT * FROM properties WHERE id = $1"
    values = [ident]
    db.prepare("find", sql)
    prop_hashes = db.exec_prepared("find", values)
    props = prop_hashes.map{|prop|PropertyTracker.new(prop)}
    db.close
    return props
  end

  def PropertyTracker.find_by_address(address)
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'});
    sql = "SELECT * FROM properties WHERE address = $1"
    value = [address]
    db.prepare("find_by_address", sql)
    prop_hashes = db.exec_prepared("find_by_address", value)
    props = prop_hashes.map{|prop|PropertyTracker.new(prop)}
    db.close
    return props
  end


end
