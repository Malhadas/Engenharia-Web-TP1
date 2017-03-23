class Xdk < Object

  # Sensor Types
  ACCELEROMETER = '0'
  GYROSCOPE     = '1'
  MAGNETOMETER  = '2'
  HUMIDITY      = '3'
  PRESSURE      = '4'
  TEMPERATURE   = '5'
  ACOUSTIC      = '6'
  LUMINOSITY    = '7'

  MIN_ACCELEROMETER = -1.5 # g
  MAX_ACCELEROMETER =  1.5

  MIN_GYROSCOPE = -129 # º/segundo
  MAX_GYROSCOPE =  120

  MIN_MAGNETOMETER = 0 # microTesla
  MAX_MAGNETOMETER = 200

  MIN_HUMIDITY = 0 # %
  MAX_HUMIDITY = 100

  MIN_PRESSURE = 0 # Pa
  MAX_PRESSURE = 60

  MIN_TEMPERATURE = -100 # ºC
  MAX_TEMPERATURE =  100

  MIN_ACOUSTIC = 0 # dB
  MAX_ACOUSTIC = 85

  MIN_LUMINOSITY = 0 # %
  MAX_LUMINOSITY = 100

  def initialize
    @accelerometer = simulate(ACCELEROMETER)
    @gyroscope     = simulate(GYROSCOPE)
    @magnetometer  = simulate(MAGNETOMETER)
    @humidity      = simulate(HUMIDITY)
    @pressure      = simulate(PRESSURE)
    @temperature   = simulate(TEMPERATURE)
    @acoustic      = simulate(ACOUSTIC)
    @luminosity    = simulate(LUMINOSITY)
  end

  def self.ACCELEROMETER
    ACCELEROMETER
  end

  def self.GYROSCOPE
    GYROSCOPE
  end

  def self.MAGNETOMETER
    MAGNETOMETER
  end

  def self.HUMIDITY
    HUMIDITY
  end

  def self.PRESSURE
    PRESSURE
  end

  def self.TEMPERATURE
    TEMPERATURE
  end

  def self.ACOUSTIC
    ACOUSTIC
  end

  def self.LUMINOSITY
    LUMINOSITY
  end

  def simulateALL
    @accelerometer = simulate(ACCELEROMETER)
    @gyroscope     = simulate(GYROSCOPE)
    @magnetometer  = simulate(MAGNETOMETER)
    @humidity      = simulate(HUMIDITY)
    @pressure      = simulate(PRESSURE)
    @temperature   = simulate(TEMPERATURE)
    @acoustic      = simulate(ACOUSTIC)
    @luminosity    = simulate(LUMINOSITY)
  end

  def simulateNewALL
    @accelerometer = simulate_new(ACCELEROMETER)
    @gyroscope     = simulate_new(GYROSCOPE)
    @magnetometer  = simulate_new(MAGNETOMETER)
    @humidity      = simulate_new(HUMIDITY)
    @pressure      = simulate_new(PRESSURE)
    @temperature   = simulate_new(TEMPERATURE)
    @acoustic      = simulate_new(ACOUSTIC)
    @luminosity    = simulate_new(LUMINOSITY)
  end

  def simulate_new(simulation_type)
    puts case simulation_type
           when ACCELEROMETER
             @accelerometer =  range_variation(-0.1, 0.1, @accelerometer, MIN_ACCELEROMETER, MAX_ACCELEROMETER)
             return @accelerometer
           when GYROSCOPE
             @gyroscope =  range_variation(-3, 3, @gyroscope, MIN_GYROSCOPE, MAX_GYROSCOPE)
             return @gyroscope
           when MAGNETOMETER
             @magnetometer =  range_variation(-3, 3, @magnetometer, MIN_MAGNETOMETER, MAX_MAGNETOMETER)
             return @magnetometer
           when HUMIDITY
             @humidity =  range_variation(-3, 3, @humidity, MIN_HUMIDITY, MAX_HUMIDITY)
             return @humidity
           when PRESSURE
             @pressure =  range_variation(-3, 3, @pressure, MIN_PRESSURE, MAX_PRESSURE)
             return @pressure
           when TEMPERATURE
             @temperature =  range_variation(-3, 3, @temperature, MIN_TEMPERATURE, MAX_TEMPERATURE)
             return @temperature
           when ACOUSTIC
             @acoustic =  range_variation(-3, 3, @acoustic, MIN_ACOUSTIC, MAX_ACOUSTIC)
             return @acoustic
           when LUMINOSITY
             @luminosity =  range_variation(-3, 3, @luminosity, MIN_LUMINOSITY, MAX_LUMINOSITY)
             return @luminosity
         end
  end

  def simulate(simulation_type)
    puts case simulation_type
           when ACCELEROMETER
             return range(MIN_ACCELEROMETER, MAX_ACCELEROMETER)
           when GYROSCOPE
             return range(MIN_GYROSCOPE, MAX_GYROSCOPE)
           when MAGNETOMETER
             return range(MIN_MAGNETOMETER, MAX_MAGNETOMETER)
           when HUMIDITY
             return range(MIN_HUMIDITY, MAX_HUMIDITY)
           when PRESSURE
             return range(MIN_PRESSURE, MAX_PRESSURE)
           when TEMPERATURE
             return range(MIN_TEMPERATURE, MAX_TEMPERATURE)
           when ACOUSTIC
             return range(MIN_ACOUSTIC, MAX_ACOUSTIC)
           when LUMINOSITY
             return range(MIN_LUMINOSITY, MAX_LUMINOSITY)
         end
  end

  def range_variation(min_var, max_var, instance_var, instance_var_min, instance_var_max)
    variation = range(min_var, max_var)
    if instance_var + variation < instance_var_min or instance_var + variation < instance_var_max
      return instance_var - variation
    else
      return instance_var + variation
    end
  end

  def range (min, max)
    rand * (max-min) + min
  end


end

#u = Xdk.new
#value = u.simulate_new(Xdk.ACOUSTIC)
#puts("valor="+value.to_s)