module Cover

  class InsufficientCoverageError < StandardError; end

  # = Report
  #
  # Responsible for analyzing a generated HTML report from RCov
  #
  class Report
    
    attr_reader :threshold
    
    # Create a new instance with the file to analyze
    def initialize(output_file, threshold)
      @output_file = output_file
      @threshold   = threshold
    end
    
    # The reported coverage for the tests (uses the overall code coverage number)
    def coverage
      @_coverage ||= if File.exist?(@output_file)
        # <td><tt class='coverage_code'>78.95%</tt>&nbsp;</td>
        # <div class="percent_graph_legend"><tt class='coverage_total'>78.95%</tt></div>
        # 
        # content = File.read(@output_file)
        # matches = content.scan(/<td><tt class='coverage_code'>78.95%</tt>&nbsp;</td>/)
        
        content = File.read(@output_file)
        matches = content.scan(/<td><tt class='coverage_code'>(\d+\.\d+)%<\/tt>&nbsp;<\/td>/)

        if matches.empty?
          matches = content.scan(/<div class="percent_graph_legend"><tt class='coverage_total'>(\d+\.\d+)%<\/tt><\/div>/)
        end

        matches.first.to_s.to_f
      end
      
      @_coverage ||= 0
    end
    
    # Is the current coverage below the configured threshold? (see Configuration.threshold)
    def below_threshold?
      coverage < threshold
    end
    
    # Ensure that the coverage is at an acceptable level, raise an exception if it is not
    def ensure!
      if below_threshold?
        message = "Reported coverage of #{coverage}% is less than the required #{threshold}%"
        raise(Cover::InsufficientCoverageError, message)
      end
    end
    
  end
end