window.addEventListener('turbolinks:load',function(){
    var button = document.getElementById('xlsx');
    button.addEventListener('click',function(){
        var array1 =
        [
          ["apple", "banana", "cherry"],
          [1, 2, 3]
        ];

        function sheet_to_workbook(sheet, opts) {
            var n = opts && opts.sheet ? opts.sheet : "Sheet1";
            var sheets = {}; sheets[n] = sheet;
            return { SheetNames: [n], Sheets: sheets };
          }
        function aoa_to_workbook(data, opts) {
            return sheet_to_workbook(XLSX.utils.aoa_to_sheet(data, opts), opts);
        }  
        function s2ab(s) {
            var buf = new ArrayBuffer(s.length);
            var view = new Uint8Array(buf);
            for (var i = 0; i != s.length; ++i) view[i] = s.charCodeAt(i) & 0xFF;
              return buf;
        }
        function func1() {
            
            var write_opts = {
              type: 'binary'
            };
        
          
            var wb = aoa_to_workbook(array1);
            var wb_out = XLSX.write(wb, write_opts);
        
           
            var blob = new Blob([s2ab(wb_out)], { type: 'application/octet-stream' });
        
            saveAs(blob, 'myExcelFile.xlsx');

    });
});