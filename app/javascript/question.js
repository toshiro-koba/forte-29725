function question() {
  const submit = document.getElementById("submit");
  submit.addEventListener("click", (e) => {
    const formData = new FormData(document.getElementById("form"));
    const XHR = new XMLHttpRequest();
    XHR.open("POST", "/rooms", true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
        return null;
      } else if (XHR.response.room != null) {
        const room = XHR.response.room;
        const tag = XHR.response.tag;
        const user = XHR.response.user;
        const content = XHR.response.content;
        const list = document.getElementById("list");
        const formTitle = document.getElementById("question_title");
        const formText = document.getElementById("content");
        const formUser = document.getElementById("user");
        const formTag = document.getElementById("game-tag");
        const HTML = `
          <div class="index">
            <div class="index-tag">
              ${tag.game_title}
            </div>
            <div class="index-decoration"></div>
          </div>
          <div class="room-name">
            <div class="question-title">
              ${room.question_title}
            </div>
            <div class="question-space">
              <div class="main-content">
                <div class="icons-space">
                </div>
                <div class="question-texts">
                  <div class="question-nickname">
                  ${user.nickname}
                  </div>
                  <div class="question-sentence">
                    <div class="question-Q">
                      Q.
                    </div>
                    <div class="question-content">
                    ${content}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>`;
        list.insertAdjacentHTML("afterend", HTML);
        formTitle.value = "";
        formText.value = "";
        formUser.value = "";
        formTag.value = "";
        if (document.getElementById("errors") != null) {
          const errors = document.getElementById("errors");
          errors.remove()
        }
      } else {
        const HTML = `
        <ul id='errors'>
          <li>${XHR.response.title_err}</li>
          <li>${XHR.response.user_err}</li>
          <li>${XHR.response.tag_err}</li>
          <li>${XHR.response.content_err}</li>
        </ul>`;
        const error = document.getElementById("error");
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
window.addEventListener("load", question);