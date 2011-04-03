module Interface
  # Contains information about this gem's version
  module Version
    MAJOR = 0
    MINOR = 0
    PATCH = 4

    # Returns a version string by joining <tt>MAJOR</tt>, <tt>MINOR</tt>, and <tt>PATCH</tt> with <tt>'.'</tt>
    #
    # Example
    #
    #   Version.string # '1.0.2'
    def self.to_s
      [MAJOR, MINOR, PATCH].join('.')
    end
  end
end