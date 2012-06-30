# HISTORY

## 2.1.0 // WIP

- Added Simplified Chinese translation. Thanks to archonwang.
- Added Bulgarian translation. Thanks to Ivan Cenov.
- Resolved #69.
  Tags autocomplete now can be either "cached" (available list of tags is
  included right into the issue edit form and Autocompleter.Local is used) or
  non-cached (as it was before - using Ajax.Autocompleter).
- Removed Ajax.Autocompleter view script. AutoComplete controller now returns
  JSON array instead.
