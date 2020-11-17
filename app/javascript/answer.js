function answer() {
  const submit = document.getElementById("submit-answer");
  submit.addEventListener("click", (e) => {
    const formData = new FormData(document.getElementById("form-answer"));
    const XHR = new XMLHttpRequest();
    XHR.open("POST", "/messages", true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
        return null;
      } else if (XHR.response.message != null) {
        const message = XHR.response.message;
        const user = XHR.response.user;
        const list = document.getElementById("list-answer");
        const formText = document.getElementById("content-answer");
        const HTML = `
          <div class="main-content">
            <div class="question-texts">
              <div class="question-nickname">
              ${user.nickname}
              </div>
              <div class="question-sentence">
                <div class="question-A">
                  A.
                </div>
                <div class="question-content">
                ${message}
                </div>
              </div>
            </div>
          </div>`;
        list.insertAdjacentHTML("afterend", HTML);
        formText.value = "";
        if (document.getElementById("errors") != null) {
          const errors = document.getElementById("errors");
          errors.remove()
        }
        const formAnswer = document.getElementById("form-answer");
        formAnswer.remove()
      } else {
        const HTML = `
          <div id='errors'>${XHR.response.content_err}</div>
          `;
        const error = document.getElementById("error-answer");
        if (document.getElementById("errors") != null) {
          const errors = document.getElementById("errors");
          errors.remove()
        }
        error.insertAdjacentHTML("afterend", HTML);
      }
    };
    e.preventDefault();
  });
}
window.addEventListener("load", answer);