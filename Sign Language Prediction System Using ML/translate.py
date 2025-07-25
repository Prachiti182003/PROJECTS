
from tkinter import *
from tkinter import ttk, messagebox
from googletrans import Translator, LANGUAGES


# Function to translate text
def translate_text():
    try:
        src_lang = source_lang.get()
        dest_lang = target_lang.get()
        text = input_text.get("1.0", END)

        if not text.strip():
            messagebox.showerror("Error", "Please enter text to translate")
            return

        translator = Translator()
        translated = translator.translate(text, src=src_lang, dest=dest_lang)
        output_text.delete("1.0", END)
        output_text.insert(END, translated.text)
    except Exception as e:
        messagebox.showerror("Translation Error", str(e))


# GUI Setup
def create_translator_gui():
    root = Tk()
    root.geometry('1100x320')
    root.resizable(0, 0)
    root.title('Language Translator')
    root.configure(bg='skyblue')

    Label(root, text="Language Translator", font="Arial 20 bold", bg='skyblue').pack()

    # Input text area
    Label(root, text="Enter text", font="Arial 13 bold", bg="white smoke").place(x=165, y=90)
    global input_text
    input_text = Text(root, font="Arial 12", height=5, width=50)
    input_text.place(x=30, y=120)

    # Output text area
    Label(root, text="Translated text", font="Arial 13 bold", bg="white smoke").place(x=750, y=90)
    global output_text
    output_text = Text(root, font="Arial 12", height=5, width=50)
    output_text.place(x=600, y=120)

    # Language selection
    languages = list(LANGUAGES.values())

    Label(root, text="From Language", font="Arial 12 bold", bg='skyblue').place(x=100, y=260)
    global source_lang, target_lang
    source_lang = ttk.Combobox(root, values=languages, state='readonly')
    source_lang.place(x=230, y=260)
    source_lang.set("english")

    Label(root, text="To Language", font="Arial 12 bold", bg='skyblue').place(x=600, y=260)
    target_lang = ttk.Combobox(root, values=languages, state='readonly')
    target_lang.place(x=730, y=260)
    target_lang.set("french")

    # Translate Button
    Button(root, text="Translate", font="Arial 12 bold", bg="green", fg="white", command=translate_text).place(x=500, y=260)

    root.mainloop()



