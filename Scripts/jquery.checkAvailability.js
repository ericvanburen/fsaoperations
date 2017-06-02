/* jQuery checkAvailability plugin
 * Examples and documentation at: http://www.jqeasy.com/
 * Version: 1.0 (22/03/2010)
 * No license. Use it however you want. Just keep this notice included.
 * Requires: jQuery v1.3+
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */
    (function($){
        $.fn.checkAvailability = function(opts) {
            opts = $.extend({
            target: '#response',
			trigger: '#btnCheck', 
			ajaxSource: 'checkBorrowerNumber.aspx',
			fireOnKeypress: true
        }, opts || {});
		
		var $this = $(this);
		
		if (opts.fireOnKeypress) {
			$this.keyup(function() {
				checkUsername();
			});
			
			$this.keypress(function(event) {
				if (event.keyCode == 13) {
					event.preventDefault();
					return false;
				}
			});
		};
		
		$(opts.trigger).click(function() {
			checkUsername();
        });
		
		function checkUsername() {
				$(opts.target).html('<img src="loading.gif"> checking availability...');
				usernameLookup(); 
		};
		
		function usernameLookup() { 
			var val = $this.val();
			$.ajax({ 
					url: opts.ajaxSource, 
					data: {fn:val,s:Math.random()},
					success: function(html){
						$(opts.target).html(html);
					},
					error:function (){
						$(opts.target).html('Sorry, but there was an error loading the borrower number.');
					}
			}); 
		};
		
		function validateUsername(str) {
		    return (/d{10}/.test($this.val()));
		};
	};
})(jQuery);