require File.dirname(__FILE__) + '/../test_helper'

module Cover
  class ReportTest < Test::Unit::TestCase
    
    context "An instance of the Cover::Report class" do
      setup { @fixture_path = File.dirname(__FILE__) + '/../fixtures' }
      
      should "be able to find the coverage for the 0.8.3.4 version of Rcov" do
        report = Report.new("#{@fixture_path}/coverage_0.8.3.4.html", 100)
        report.coverage.should == 78.95
      end
      
      should "be able to find the coverage for the 0.9.2.1 version of Rcov" do
        report = Report.new("#{@fixture_path}/coverage_0.9.2.1.html", 100)
        report.coverage.should == 78.95
      end
      
      should "report a coverage of 0 if the file doesn't exist" do
        report = Report.new("#{@fixture_path}/missing.html", 100)
        report.coverage.should == 0
      end
      
      should "know the coverage threshold" do
        report = Report.new('file', 95)
        report.threshold.should == 95
      end
      
      should "only read the file once when reporting coverage" do
        file = "#{@fixture_path}/coverage_0.8.3.4.html"
        File.expects(:read).with(file).once.returns('report')
        
        report = Report.new(file, 100)
        2.times { report.coverage }
      end
      
      should "know that the reported coverage is not below the threshold" do
        report = Report.new('file', 100)
        report.stubs(:threshold).with().returns(95)
        report.stubs(:coverage).with().returns(96.0)
        
        report.below_threshold?.should be(false)
      end
      
      should "know that the reported coverage is below the threshold" do
        report = Report.new('file', 100)
        report.stubs(:threshold).with().returns(95)
        report.stubs(:coverage).with().returns(94.9)
        
        report.below_threshold?.should be(true)
      end
      
      should "not raise an exception when coverage is above allowed limit" do
        report = Report.new('file', 100)
        report.stubs(:below_threshold?).with().returns(false)
        
        assert_nothing_raised { report.ensure! }
      end
      
      should "raise an exception when the coverage dips below allowed limit" do
        report = Report.new('file', 100)
        report.stubs(:below_threshold?).with().returns(true)
        report.stubs(:coverage).with().returns(10.0)
        report.stubs(:threshold).with().returns(100.0)
        
        assert_raise(Cover::InsufficientCoverageError) { report.ensure! }
      end
      
      should "have a message when the coverage dips below limit" do
        report = Report.new('file', 100)
        report.stubs(:below_threshold?).with().returns(true)
        report.stubs(:coverage).with().returns(10.0)
        report.stubs(:threshold).with().returns(100.0)
        
        begin
          report.ensure!
        rescue Exception => e
          nil
        end
        
        e.message.should == "Reported coverage of 10.0% is less than the required 100.0%"
      end
      
    end
    
  end
end