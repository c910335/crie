class Crie
  VERSION = "0.1.0"
  CT_ROOT = {"_keep" => nil}

  macro add(pattern)
    {% node = CT_ROOT %}
    {% for char in pattern.chars %}
      {% if !node[char] %}
        {% node[char] = {"_keep" => nil} %}
      {% end %}
      {% node = node[char] %} # ameba:disable Lint/UselessAssign
    {% end %}
  end

  macro add_all(patterns)
    {% for pattern in patterns %}
      Crie.add({{pattern}})
    {% end %}
  end

  macro add_suffixes_of(pattern)
    {% for c in 0...pattern.size %}
      Crie.add({{pattern[c..-1]}})
    {% end %}
  end

  macro <<(pattern)
    {% if pattern.is_a? ArrayLiteral %}
      Crie.add_all({{pattern}})
    {% else %}
      Crie.add({{pattern}})
    {% end %}
  end

  macro search(pattern)
    {% node = CT_ROOT %}
    {% c = 0 %}
    {% for char in pattern.chars %}
      {% if node[char] %}
        {% c = c + 1 %}
        {% node = node[char] %} # ameba:disable Lint/UselessAssign
      {% else %}
        {% node = {"_keep" => nil} %} # ameba:disable Lint/UselessAssign
      {% end %}
    {% end %}
    {{c}}
  end

  macro __to_named_tuple(node)
    {% if node.size == 1 %}
      NamedTuple.new
    {% else %}
      {
        {% for key in node.keys %}
          {% if key != "_keep" %}
            "{{key.id}}": __to_named_tuple({{node[key]}}),
          {% end %}
        {% end %}
      }
    {% end %}
  end

  macro finished
    ROOT = __to_named_tuple({{CT_ROOT}})
  end

  def search(pattern)
    node = ROOT
    c = 0
    pattern.each_char do |char|
      if node[char.to_s]?
        c += 1
        node = node[char.to_s]
      else
        break
      end
    end
    c
  end
end
