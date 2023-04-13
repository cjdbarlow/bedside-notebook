# How to build
## CLI
quarto preview

## R
quarto::quarto_render
quarto::quarto_preview

# To do:

* Broken links
* Images to markdown style
* Get SVGs working in pdf output - prob convert to pdf
* Make the search box prettier
* Glossary highlight only once per section
* Autolink to terms ?disease ?management
* Correct image size when column-margin images have captions

# Decisions

* Where to put rhabdo, CIM, CIN
	* Rhabdo under fluid
	* CIM, CIN under neuromuscular

* Infection
	* Move system-specific infections to that system
	* New infective subgroups
		* ?where would TB meningitis go; under TB, separate neuro infection, under meningitis...