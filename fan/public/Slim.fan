using afPlastic
using afEfan

** (Service) - 
** Non-caching service methods for parsing and compiling Slim templates efan templates, and for rendering HTML.
** 
** For further information on the 'ctx' parameter, see 
** [efan: Passing Data]`http://repo.status302.com/doc/afEfan/#ctx`
** 
** Note: This class is available as a service in IoC v3 under the 'root' scope with an ID of 'afSlim::Slim'.
const class Slim {
	
	** The void tag ending style for compiled templates
			const TagStyle tagStyle

	private const EfanCompiler	efanCompiler	:= EfanCompiler()
	private const SlimParser	slimParser
	
	** Creates a 'Slim' instance, setting the ending style for tags.
	** 
	** Defaults to 'TagStyle.html'.
	new make(TagStyle tagStyle := TagStyle.html) {
		this.tagStyle	= tagStyle
		this.slimParser	= SlimParser(tagStyle)
	}
	
	** Parses the given slim template into an efan template.
	** 
	** 'srcLocation' may anything - used for meta information only.
	Str parseFromStr(Str slimTemplate, Uri? srcLocation := null) {
		srcLocation	=  srcLocation ?: `from/slim/template`
		tree := SlimLineRoot()
		slimParser.parse(srcLocation, slimTemplate, tree)
		buf	 := StrBuf(slimTemplate.size)
		efan := tree.toEfan(buf).toStr.trim
		if (efan.startsWith("%>"))
			efan = efan[2..-1]
		if (efan.endsWith("<%#"))
			efan = efan[0..-4]
		return efan
	}

	** Parses the given slim file into an efan template.
	Str parseFromFile(File slimFile) {
		srcLocation	:=  slimFile.normalize.uri
		return parseFromStr(slimFile.readAllStr, srcLocation)
	}

	** Compiles a renderer from the given slim template.
	** 
	** 'srcLocation' may anything - used for meta information only.
	EfanMeta compileFromStr(Str slimTemplate, Type? ctxType := null, Type[]? viewHelpers := null, Uri? srcLocation := null) {
		srcLocation	=  srcLocation ?: `from/slim/template`
		efan		:= this.parseFromStr(slimTemplate, srcLocation)
		template	:= efanCompiler.compile(srcLocation, efan, ctxType, viewHelpers ?: Type#.emptyList)
		return template
	}

	** Compiles a renderer from the given slim file.
	EfanMeta compileFromFile(File slimFile, Type? ctxType := null, Type[]? viewHelpers := null) {
		srcLocation	:= slimFile.normalize.uri
		efan		:= this.parseFromStr(slimFile.readAllStr, srcLocation)
		template	:= efanCompiler.compile(srcLocation, efan, ctxType, viewHelpers ?: Type#.emptyList)
		return template
	}

	** Renders the given slim template into HTML.
	** 
	** 'srcLocation' may anything - used for meta information only.
	Str renderFromStr(Str slimTemplate, Obj? ctx := null, Type[]? viewHelpers := null, Uri? srcLocation := null) {
		template := this.compileFromStr(slimTemplate, ctx?.typeof, viewHelpers, srcLocation)
		return template.render(ctx)
	}

	** Renders the given slim template file into HTML.
	Str renderFromFile(File slimFile, Obj? ctx := null, Type[]? viewHelpers := null) {
		template := this.compileFromFile(slimFile, ctx?.typeof, viewHelpers)
		return template.render(ctx)
	}
}

