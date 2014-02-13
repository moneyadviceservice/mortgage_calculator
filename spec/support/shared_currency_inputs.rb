shared_examples_for "currency inputs" do |attributes|
  attributes.each do |attribute|
    it "#{attribute} accepts strings" do
      subject.public_send("#{attribute}=", "1000")
      subject.public_send("#{attribute}").should == 1000
    end

    it "#{attribute} accepts strings with commas" do
      subject.public_send("#{attribute}=", "1,000,000.01")
      subject.public_send("#{attribute}").should == 1000000.01
    end

    it "#{attribute} accepts integers" do
      subject.public_send("#{attribute}=", 1000)
      subject.public_send("#{attribute}").should == 1000
    end

    it "#{attribute} accepts floats" do
      subject.public_send("#{attribute}=", 1000.01)
      subject.public_send("#{attribute}").should == 1000.01
    end
  end
end

