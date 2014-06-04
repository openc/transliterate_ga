# encoding: UTF-8
require_relative '../spec_helper'
require 'transliterate_ga'

describe TransliterateGa do
  before do
    @lat_str = "cereTlis quCa"
    @geo_str = "ცერეთლის ქუჩა"
  end

  describe "#latinize" do
    it "should convert to latin characters" do
      TransliterateGa.latinize(@geo_str).should == 'tseretlis qucha'
    end
  end

  describe "#georgianize" do
    it "should convert to georgian characters" do
      TransliterateGa.georgianize(@lat_str).should == @geo_str
    end
  end

  describe "#is_georgian?" do
    it "should be true for georgian alphabet" do
      TransliterateGa.is_georgian?(@geo_str).should be true
    end

    it "should not be true for latin alphabet" do
      TransliterateGa.is_georgian?(@lat_str).should_not be true
    end
  end

  describe "#is_latin?" do
    it "should be true for latin alphabet" do
      TransliterateGa.is_latin?(@lat_str).should be true
    end

    it "should be true for georgian alphabet" do
      TransliterateGa.is_latin?(@geo_str).should_not be true
    end
  end

end