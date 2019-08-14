require "./spec_helper"

describe Crie do
  context "Compile Time" do
    describe "<<" do
      it "adds a string into trie" do
        Crie << "1 string"
        Crie::ROOT[:"1"][:" "][:s][:t][:r][:i][:n][:g].should eq(NamedTuple.new)
      end

      it "adds strings into trie" do
        Crie << ["2 string", "3 string"]
        Crie::ROOT[:"2"][:" "][:s][:t][:r][:i][:n][:g].should eq(NamedTuple.new)
        Crie::ROOT[:"3"][:" "][:s][:t][:r][:i][:n][:g].should eq(NamedTuple.new)
      end
    end

    describe "add_suffixes_of" do
      it "adds all suffixes into trie" do
        Crie.add_suffixes_of("suffix")
        Crie::ROOT[:s][:u][:f][:f][:i][:x].should eq(NamedTuple.new)
        Crie::ROOT[:u][:f][:f][:i][:x].should eq(NamedTuple.new)
        Crie::ROOT[:f][:f][:i][:x].should eq(NamedTuple.new)
        Crie::ROOT[:f][:i][:x].should eq(NamedTuple.new)
        Crie::ROOT[:i][:x].should eq(NamedTuple.new)
        Crie::ROOT[:x].should eq(NamedTuple.new)
      end
    end

    describe "search" do
      it "returns the length of the longest prefix in trie" do
        Crie << "4 string"
        Crie.search("4 string").should eq(8)
        Crie.search("4 strong").should eq(5)
        Crie.search("4 str").should eq(5)
      end
    end
  end

  context "Running Time" do
    describe "#search" do
      it "returns the length of the longest prefix in trie" do
        Crie << "5 string"
        crie = Crie.new
        crie.search("5 string").should eq(8)
        crie.search("5 strong").should eq(5)
        crie.search("5 str").should eq(5)
      end
    end
  end
end
