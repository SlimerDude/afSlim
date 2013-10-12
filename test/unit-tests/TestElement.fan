
internal class TestElement : SlimTest {
	
	Void testTags() {
s := """tag"""
		text := compiler.compileFromStr(``, s)
		verifyEq(text, "<tag></tag>")
	}

	Void testText() {
s := """tag text"""
		text := compiler.compileFromStr(``, s)
		verifyEq(text, "<tag>text</tag>")
	}

	Void testAttributes() {
s := """tag(data="wotever") text"""
		text := compiler.compileFromStr(``, s)
		verifyEq(text, "<tag data=\"wotever\">text</tag>")
	}

	Void testAttributes2() {
s := """tag (data="wotever") text"""
		text := compiler.compileFromStr(``, s)
		verifyEq(text, "<tag data=\"wotever\">text</tag>")
	}

	Void testAttributesSquare() {
s := """tag[data="wotever"] (text)"""
		text := compiler.compileFromStr(``, s)
		verifyEq(text, "<tag data=\"wotever\">(text)</tag>")
	}

	Void testAttributesSquare2() {
s := """tag [data="wotever"] (text)"""
		text := compiler.compileFromStr(``, s)
		verifyEq(text, "<tag data=\"wotever\">(text)</tag>")
	}

	Void testAttributesCurly() {
s := """tag{data="wotever"} [text]"""
		text := compiler.compileFromStr(``, s)
		verifyEq(text, "<tag data=\"wotever\">[text]</tag>")
	}

	Void testAttributesCurly2() {
s := """tag {data="wotever"} [text]"""
		text := compiler.compileFromStr(``, s)
		verifyEq(text, "<tag data=\"wotever\">[text]</tag>")
	}

	Void testId() {
s := """tag#id"""
		text := compiler.compileFromStr(``, s)
		verifyEq(text, "<tag id=\"id\"></tag>")
	}

	Void testClass() {
s := """tag.class"""
		text := compiler.compileFromStr(``, s)
		verifyEq(text, "<tag class=\"class\"></tag>")
	}

	Void testMultiClass() {
s := """tag.class1.class2"""
		text := compiler.compileFromStr(``, s)
		verifyEq(text, "<tag class=\"class1 class2\"></tag>")
	}

	Void testEverythingTogether() {
s := """tag#id.class (wot="ever") stuff"""
		text := compiler.compileFromStr(``, s)
		verifyEq(text, """<tag id="id" class="class" wot="ever">stuff</tag>""")
	}

	Void testNameAndText() {
s := """title dude :: still text!"""
		text := compiler.compileFromStr(``, s)
		verifyEq(text, """<title>dude :: still text!</title>""")
	}

	Void testNameAndAttr() {
s := """dude (name="bier") """
		text := compiler.compileFromStr(``, s)
		verifyEq(text, """<dude name="bier"></dude>""")
	}

	Void testAttributesMixed() {
s := """tag(data="[wot]{ever}") text"""
		text := compiler.compileFromStr(``, s)
		verifyEq(text, "<tag data=\"[wot]{ever}\">text</tag>")
	}
}