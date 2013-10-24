
internal class TestBugFixes : SlimTest {
	
	Void testBugFromGundamIndex() {
s := """		p
        			| More recently, I discovered the 
        			a (href="http://fantom.org/") Fantom programming language
        			| , a niffty pragmatic language"""
		text := slim.parseFromStr(s)

e := """<p><%#
        	%>More recently, I discovered the <%#
        	%><a href="http://fantom.org/">Fantom programming language</a><%#
        	%>, a niffty pragmatic language<%#
        %></p>"""

		verifyEq(text, e)
	}

	Void testBugFromGundamIndex2() {
s := """
        		p
        			| More recently
        			| re-writing Gundam in Fantom.
        		p
        			| And so was born Gundam v2.
        """
		renderer := slim.compileFromStr(s)
		text 	 := renderer.render(null)
		verifyEq(text, "<p>More recently re-writing Gundam in Fantom.</p><p>And so was born Gundam v2.</p>")
	}
	
	// Fook this - I discovered that *I* want text on multilines - it just looks better!
//	Void testBugFromGundamIndex3() {
//		// don't allow text on multilines - for it leads you down a BAD path, i.e. testBugFromGundamIndex
//		// will no longer work
//s := """		p	| More recently
//        			| re-writing Gundam in Fantom.
//        		p	| And so was born Gundam v2.
//        """
//		renderer := slim.compileFromStr(s)
//		text 	 := renderer.render(null)
//		print(text)
//		verifyEq(text, "<p>| More recentlyre-writing Gundam in Fantom.</p><p>| And so was born Gundam v2.</p>")
//	}

	// this is how I do it!...
	Void testHowMultilineUsage1() {
s := """		p	| More recently
        			| re-writing Gundam in Fantom.
        """
		renderer := slim.compileFromStr(s)
		text 	 := renderer.render(null)
		print(text)
		verifyEq(text, "<p>More recently re-writing Gundam in Fantom.</p>")
	}

	// this is how I do it!...
	Void testHowMultilineUsage2() {
s := """		p |	And so was born Gundam v2.
        		 	Maybe there'll be a v3?
        """
		renderer := slim.compileFromStr(s)
		text 	 := renderer.render(null)
		print(text)
		verifyEq(text, "<p>And so was born Gundam v2.\nMaybe there'll be a v3?</p>")
	}
}