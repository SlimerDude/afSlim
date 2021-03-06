
internal const class SlimLineHtmlCommentCompiler : SlimLineCompiler {
	
	override Bool matches(Str line) {
		line.startsWith("/!")
	}
	
	override SlimLine compile(Str line) {
		SlimLineHtmlComment(escape(line[2..-1].trim))
	}
}

internal class SlimLineHtmlComment : SlimLine {

	Str comment
	
	new make(Str comment) {
		this.comment = comment
	}
	
	override Void onEntry(StrBuf buf) {
		indent(buf)
		buf.add("<!-- ${comment} -->")
		newLine(buf)
	}

	override Void onExit(StrBuf buf) { }
}
