{
  key = FILENAME " ||";
  for (i = 1; i < NF; ++i) {
    n = i+1;
    if ($n ~ /seconds/) {
      metric[key] += $i;
      count[key] += 1;
      squares[key] += $i * $i;
    }
    key = key " " $i;
  }
}

/^File size/ {
  filesize[FILENAME] = $3;
}

function size_format(bytes) {
  return bytes / 1024.0 " Kb"
}

END {
  print " PARAM || interpreted || compiled || %";
  for (key in metric) {
    mean = metric[key] / count[key];
    mean_sq = squares[key] / count[key];
    sq_mean = mean * mean;

    suf = ""
    if (key ~ /int/) {
      comp_key = key
      gsub("int", "comp", comp_key);
      if (count[comp_key] ) {
        mean_comp = metric[comp_key] / count[comp_key];
        mean_sq_comp = squares[comp_key] / count[comp_key];
        sq_mean_comp = mean_comp * mean_comp;
        if (mean_comp) {
          suf = " || " (100.0 * mean / mean_comp - 100.0) " %"
        }
        line_int = mean " +- " sqrt(mean_sq - sq_mean);
        line_comp = mean_comp " +- " sqrt(mean_sq_comp - sq_mean_comp);
        printf("%s = %s | %s %s\n", key, line_int, line_comp, suf);
      }
    }
  }

  for (mode_int in filesize) {
    if (mode_int ~ /int/) {
      mode_comp = mode_int;
      gsub("int", "comp", mode_comp);
      if (filesize[mode_comp]) {
        int_sz = filesize[mode_int]
        comp_sz = filesize[mode_comp]
        percent = 100.0 * int_sz / comp_sz;
        ratio = 100.0 / percent
        int_sz_fmt = size_format(int_sz);
        comp_sz_fmt = size_format(comp_sz);
        print "zFILE SIZE " mode_int " || " int_sz_fmt " | " comp_sz_fmt " || " percent - 100 " %, " ratio
      }
    }
  }
}