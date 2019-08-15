# Crie

[![Build Status](https://travis-ci.com/c910335/crie.svg?branch=master)](https://travis-ci.com/c910335/crie)
[![GitHub license](https://img.shields.io/github/license/c910335/crie)](https://github.com/c910335/crie/blob/master/LICENSE)

Compile-time Trie in Crystal

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     crie:
       github: c910335/crie
   ```

2. Run `shards install`

## Usage

```crystal
require "crie"

# Build Trie at compile time
Crie << "En aru'din Raszagal"
Crie << ["Khassar de templari", "Zhakul inok"]
Crie.add_suffixes_of("Terrie Khala")

# Search at compile time
Crie.search("En Taro Adun") # => 3
Crie.search("Khala dora") # => 5
Crie.search("Nas beru uhn'adarr") # => 0

# Search at run time
crie = Crie.new
crie.search("Zhara ku'nuul") # => 3
crie.search("Khas ara'shar") # => 4
crie.search("Shozak mok nul") # => 0
```

## Contributing

1. Fork it (<https://github.com/c910335/crie/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Tatsiujin Chin](https://github.com/c910335) - creator and maintainer
