# encoding: UTF-8
require "transliterate_ga/version"

module TransliterateGa
  # Set whether you want output in the terminal (for development)
  Output = false

  extend self

  # Converts Georgian script to latin;
  def latinize(raw_string, map = LANG_MAP_TO_GEO)
    new_string = raw_string.dup
    map.each do |latin, georgian|
      georgian.each do |ge|
        new_string.gsub!(ge,latin)
      end
    end
    new_string
  end

  # Converts Latin script to Georgian - uses keyboard syntax, so T => თ and t => ტ
  def georgianize(raw_string, map = LANG_MAP_TO_ENG)
    new_string = raw_string.dup
    map.each do |latin, georgian|
        new_string.gsub!(latin,georgian)
    end
    new_string
  end

  # Returns the language of the string, either Georgian or English
  def get_language(raw_string)
    ka_letters = raw_string.count("ა-ჰ")
    en_letters = raw_string.count("a-zA-Z")
    return en_letters >= ka_letters ? 'en' : 'ka'
  end

  # Returns true if the string is predominantly in Georgian characters
  def is_georgian?(raw_string)
    get_language(raw_string) == 'ka' ? true : false
  end

  # Returns true if the string is predominantly in Latin characters
  def is_latin?(raw_string)
    get_language(raw_string) == 'en' ? true : false
  end

  # Returns a string that has been simplified by Georgian language morphology rules
  #  if set to 'basic' (default) will convert common characters to their common format
  #  if set to 'extended' will also convert common word morphs to their unmorphed form
  #  ex. 'ceretlis qucha' in basic mode will output 'tseretlis qucha'
  #                       in extended mode will output 'tsereteli qucha'
  def georgian_morph(raw_string, type = 'basic')
    new_string_terms = raw_string.split(' ')
    if type == 'basic' or type == 'extended'
      new_string_terms.each do |term|
        for i in 0..term.length-1
          if term[i] == 'c' && term[i+1] != nil && term[i+1] != 'h'
            term[i] = 'ts'
          end
          if term[i] == 'f'
            term[i] = 'p'
          end
          if term[i] == 'p' && term[i+1] != nil && term[i+1] == 'h'
            term[i..i+1] = 'p'
          end
          if term[i] == 'x'
            term[i] = 'kh'
          end
        end
      end
    end
    if type == 'extended'
      new_string_terms.each do |term|
        term.gsub!('eblis','ebeli') if term.include?('eblis')
        term.gsub!('etlis','eteli') if term.include?('etlis')
        term.gsub!('dzis','dze') if term.include?('dzis')
        term[term.length-1] = '' if term[term.length-1] == 's' # remove any 's' from the end of a term
      end
    end
    return new_string_terms.join(' ')
  end


  # CONSTANTS #
  LANG_MAP_TO_GEO = { 'a'   => ['ა'],
                      'b'   => ['ბ'],
                      'g'   => ['გ'],
                      'd'   => ['დ'],
                      'e'   => ['ე'],
                      'v'   => ['ვ'],
                      'z'   => ['ზ'],
                      'i'   => ['ი'],
                      'l'   => ['ლ'],
                      'm'   => ['მ'],
                      'n'   => ['ნ'],
                      'o'   => ['ო'],
                      'zh'  => ['ჟ'],
                      'r'   => ['რ'],
                      's'   => ['ს'],
                      't'   => ['ტ','თ'],
                      'u'   => ['უ'],
                      'p'   => ['პ','ფ'],
                      'k'   => ['კ','ყ'],
                      'gh'  => ['ღ'],
                      'q'   => ['ქ'],
                      'sh'  => ['შ'],
                      'dz'  => ['ძ'],
                      'ts'  => ['ც','წ'],
                      'ch'  => ['ჩ','ჭ'],
                      'kh'  => ['ხ'],
                      'j'   => ['ჯ'],
                      'h'   => ['ჰ']  }

  LANG_MAP_TO_ENG = { 'tch' => 'ჭ',
                      'Tch' => 'ჭ',
                      'th'  => 'ტ',
                      'Th'  => 'ტ',
                      'gh'  => 'ღ',
                      'Gh'  => 'ღ',
                      'zh'  => 'ჟ',
                      'Zh'  => 'ჟ',
                      'sh'  => 'შ',
                      'Sh'  => 'შ',
                      'dz'  => 'ძ',
                      'Dz'  => 'ძ',
                      'ts'  => 'ც',
                      'Ts'  => 'ც',
                      'tz'  => 'წ',
                      'Tz'  => 'წ',
                      'ch'  => 'ჩ',
                      'Ch'  => 'ჩ',
                      'kh'  => 'ხ',
                      'Kh'  => 'ხ',
                      'W'   => 'ჭ',
                      't'   => 'ტ',
                      'T'   => 'თ',
                      'R'   => 'ღ',
                      'J'   => 'ჟ',
                      'S'   => 'შ',
                      'Z'   => 'ძ',
                      'c'   => 'ც',
                      'w'   => 'წ',
                      'C'   => 'ჩ',
                      'x'   => 'ხ',
                      'y'   => 'ყ',
                      'a'   => 'ა',
                      'b'   => 'ბ',
                      'g'   => 'გ',
                      'd'   => 'დ',
                      'e'   => 'ე',
                      'v'   => 'ვ',
                      'z'   => 'ზ',
                      'i'   => 'ი',
                      'l'   => 'ლ',
                      'm'   => 'მ',
                      'n'   => 'ნ',
                      'o'   => 'ო',
                      'r'   => 'რ',
                      's'   => 'ს',
                      'u'   => 'უ',
                      'p'   => 'პ',
                      'f'   => 'ფ',
                      'k'   => 'კ',
                      'q'   => 'ქ',
                      'j'   => 'ჯ',
                      'h'   => 'ჰ' }
end
