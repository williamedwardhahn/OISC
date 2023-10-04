from flask import Flask, request, escape
import numpy as np

app = Flask(__name__)

FIXED_LENGTH = 100
arr = np.full((FIXED_LENGTH,), ord(' '), dtype=int)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        # Convert input text to numpy array of ASCII values
        text = request.form.get('text_input')
        ascii_vals = [ord(char) for char in text.ljust(FIXED_LENGTH)[:FIXED_LENGTH]]

        global arr
        arr = np.array(ascii_vals)

    # Convert numpy array to ASCII string for display
    content = ''.join(chr(i) for i in arr)

    # HTML form for user input
    form_html = f'''
    <form method="post">
        <textarea name="text_input" rows="4" cols="50"></textarea><br>
        <input type="checkbox" name="debug" value="on"> Debug Mode<br>
        <input type="submit" value="Update"><br><br>
        <br>Rendered Content:<br>
        {content}
    </form>
    '''

    debug_output = ""
    if "debug" in request.form:
        # Display the numpy array, the raw ASCII, and the rendered HTML content
        debug_output = f'''
        <br>Integer Values:<br><br>
        {', '.join(map(str, arr))}<br>
        <br>Raw ASCII:<br>
        <pre><code>{escape(content)}</code></pre>
        '''



    return form_html + debug_output



app.run(host="0.0.0.0", port=8080, debug=True)

