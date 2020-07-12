<div class="tableDiv">
    <table class="mdl-data-table mdl-js-data-table">
        <thead>
          <tr>
            <th class="mdl-data-table__cell--non-numeric">{{ @ERROR.code?@ERROR.code:'Please, select an account or transaction first!' }} {{ @ERROR.status }}</th>
          </tr>
        </thead>
        <tbody> 
            <tr>
                <td class="mdl-data-table__cell--non-numeric">
                    Your request could not be found or.. something went wrong! <a href="/">Please try again!</a>
                </td>
            </tr>
        </tbody>
    </table>
</div>