package fuzzyfikasi_module

import "fmt"

// Fungsi Keanggotaan
func preQuiz(x float64) (rendah, sedang, tinggi float64) {
	if x >= 180 {
		rendah = 0
	} else if 100 <= x && x < 180 {
		rendah = (180 - x) / (180 - 100)
	} else if x < 100 {
		rendah = 1
	}

	if x <= 100 || x >= 260 {
		sedang = 0
	} else if 100 < x && x <= 180 {
		sedang = (x - 100) / (180 - 100)
	} else if 180 < x && x < 260 {
		sedang = (260 - x) / (260 - 180)
	}

	if x <= 180 {
		tinggi = 0
	} else if 180 < x && x < 260 {
		tinggi = (x - 180) / (260 - 180)
	} else if x >= 260 {
		tinggi = 1
	}

	return
}

func postQuiz(x float64) (rendah, sedang, tinggi float64) {
	if x >= 180 {
		rendah = 0
	} else if 100 <= x && x < 180 {
		rendah = (180 - x) / (180 - 100)
	} else if x < 100 {
		rendah = 1
	}

	if x <= 100 || x >= 260 {
		sedang = 0
	} else if 100 < x && x <= 180 {
		sedang = (x - 100) / (180 - 100)
	} else if 180 < x && x < 260 {
		sedang = (260 - x) / (260 - 180)
	}

	if x <= 180 {
		tinggi = 0
	} else if 180 < x && x < 260 {
		tinggi = (x - 180) / (260 - 180)
	} else if x >= 260 {
		tinggi = 1
	}

	return
}

func peerEvaluationKeaktifan(x float64) (kurangAktif, aktif, sangatAktif float64) {
	if x >= 10 {
		kurangAktif = 0
	} else if 6 <= x && x < 10 {
		kurangAktif = (10 - x) / (10 - 6)
	} else if x < 6 {
		kurangAktif = 1
	}

	if x <= 6 || x >= 13 {
		aktif = 0
	} else if 6 < x && x <= 10 {
		aktif = (x - 6) / (10 - 6)
	} else if 10 < x && x < 13 {
		aktif = (13 - x) / (13 - 10)
	}

	if x <= 10 {
		sangatAktif = 0
	} else if 10 < x && x < 13 {
		sangatAktif = (x - 10) / (13 - 10)
	} else if x >= 13 {
		sangatAktif = 1
	}

	return
}

func peerEvaluationBantuan(x float64) (kurangMembantu, membantu, sangatMembantu float64) {
	if x >= 10 {
		kurangMembantu = 0
	} else if 6 <= x && x < 10 {
		kurangMembantu = (10 - x) / (10 - 6)
	} else if x < 6 {
		kurangMembantu = 1
	}

	if x <= 6 || x >= 13 {
		membantu = 0
	} else if 6 < x && x <= 10 {
		membantu = (x - 6) / (10 - 6)
	} else if 10 < x && x < 13 {
		membantu = (13 - x) / (13 - 10)
	}

	if x <= 10 {
		sangatMembantu = 0
	} else if 10 < x && x < 13 {
		sangatMembantu = (x - 10) / (13 - 10)
	} else if x >= 13 {
		sangatMembantu = 1
	}

	return
}

func hasilKontribusi(x float64) (rendah, moderat, signifikan float64) {
	if x >= 100 {
		rendah = 0
	} else if 40 <= x && x < 100 {
		rendah = (100 - x) / (100 - 40)
	} else if x < 40 {
		rendah = 1
	}

	if x <= 40 || x >= 100 {
		moderat = 0
	} else if 40 < x && x <= 100 {
		moderat = (x - 40) / (100 - 40)
	} else if 60 < x && x < 100 {
		moderat = (100 - x) / (100 - 60)
	}

	if x <= 60 {
		signifikan = 0
	} else if 60 < x && x < 100 {
		signifikan = (x - 60) / (100 - 60)
	} else if x >= 100 {
		signifikan = 1
	}

	return
}

// Defuzzifikasi dengan Metode Centroid
func defuzzifyCentroid(rules []struct {
	minValue float64
	value    float64
}) float64 {
	numerator := 0.0
	denominator := 0.0

	for _, rule := range rules {
		numerator += rule.minValue * rule.value
		denominator += rule.minValue
	}

	if denominator == 0 {
		return 0
	}

	return numerator / denominator
}

// Fuzzy Inference and Defuzzification
func inferAndDefuzzify(preQuizScore, postQuizScore, keaktifanScore, bantuanScore float64) float64 {
	rendahPre, sedangPre, tinggiPre := preQuiz(preQuizScore)
	rendahPost, sedangPost, tinggiPost := postQuiz(postQuizScore)
	kurangAktif, aktif, sangatAktif := peerEvaluationKeaktifan(keaktifanScore)
	kurangMembantu, membantu, sangatMembantu := peerEvaluationBantuan(bantuanScore)

	// Aturan Fuzzy
	rules := []struct {
		minValue float64
		value    float64
	}{
		// Aturan 1 signifikan
		{min(tinggiPre, tinggiPost, sangatAktif, sangatMembantu), 100},
		// Aturan 2 signifikan
		{min(tinggiPre, tinggiPost, sangatAktif, membantu), 80},
		// Aturan 3 signifikan
		{min(tinggiPre, tinggiPost, sangatAktif, kurangMembantu), 80},
		// Aturan 4 signifikan
		{min(tinggiPre, tinggiPost, aktif, sangatMembantu), 80},
		// Aturan 5 signifikan
		{min(tinggiPre, tinggiPost, aktif, membantu), 80},
		// Aturan 6 signifikan
		{min(tinggiPre, tinggiPost, aktif, kurangMembantu), 80},
		// Aturan 7 signifikan
		{min(tinggiPre, tinggiPost, kurangAktif, sangatMembantu), 80},
		// Aturan 8 signifikan
		{min(tinggiPre, tinggiPost, kurangAktif, membantu), 80},
		// Aturan 9 moderat
		{min(tinggiPre, tinggiPost, kurangAktif, kurangMembantu), 60},
		// Aturan 10 signifikan
		{min(tinggiPre, sedangPost, sangatAktif, sangatMembantu), 80},
		// Aturan 11 signifikan
		{min(tinggiPre, sedangPost, sangatAktif, membantu), 80},
		// Aturan 12 moderat
		{min(tinggiPre, sedangPost, sangatAktif, kurangMembantu), 60},
		// Aturan 13 signifikan
		{min(tinggiPre, sedangPost, aktif, sangatMembantu), 80},
		// Aturan 14 moderat
		{min(tinggiPre, sedangPost, aktif, membantu), 60},
		// Aturan 15 moderat
		{min(tinggiPre, sedangPost, aktif, kurangMembantu), 60},
		// Aturan 16 moderat
		{min(tinggiPre, sedangPost, kurangAktif, sangatMembantu), 60},
		// Aturan 17 moderat
		{min(tinggiPre, sedangPost, kurangAktif, membantu), 60},
		// Aturan 18 moderat
		{min(tinggiPre, sedangPost, kurangAktif, kurangMembantu), 60},
		// Aturan 19 moderat
		{min(tinggiPre, rendahPost, sangatAktif, sangatMembantu), 60},
		// Aturan 20 moderat
		{min(tinggiPre, rendahPost, sangatAktif, membantu), 60},
		// Aturan 21 moderat
		{min(tinggiPre, rendahPost, sangatAktif, kurangMembantu), 60},
		// Aturan 22 moderat
		{min(tinggiPre, rendahPost, aktif, sangatMembantu), 60},
		// Aturan 23 moderat
		{min(tinggiPre, rendahPost, aktif, membantu), 60},
		// Aturan 24 moderat
		{min(tinggiPre, rendahPost, aktif, kurangMembantu), 60},
		// Aturan 25 moderat
		{min(tinggiPre, rendahPost, kurangAktif, sangatMembantu), 60},
		// Aturan 26 moderat
		{min(tinggiPre, rendahPost, kurangAktif, membantu), 60},
		// Aturan 27 moderat
		{min(tinggiPre, rendahPost, kurangAktif, kurangMembantu), 60},
		// Aturan 28 signifikan
		{min(sedangPre, tinggiPost, sangatAktif, sangatMembantu), 80},
		// Aturan 29 signifikan
		{min(sedangPre, tinggiPost, sangatAktif, membantu), 80},
		// Aturan 30 moderat
		{min(sedangPre, tinggiPost, sangatAktif, kurangMembantu), 60},
		// Aturan 31 signifikan
		{min(sedangPre, tinggiPost, aktif, sangatMembantu), 80},
		// Aturan 32 moderat
		{min(sedangPre, tinggiPost, aktif, membantu), 60},
		// Aturan 33 moderat
		{min(sedangPre, tinggiPost, aktif, kurangMembantu), 60},
		// Aturan 34 moderat
		{min(sedangPre, tinggiPost, kurangAktif, sangatMembantu), 60},
		// Aturan 35 moderat
		{min(sedangPre, tinggiPost, kurangAktif, membantu), 60},
		// Aturan 36 moderat
		{min(sedangPre, tinggiPost, kurangAktif, kurangMembantu), 60},
		// Aturan 37 moderat
		{min(sedangPre, sedangPost, sangatAktif, sangatMembantu), 60},
		// Aturan 38 moderat
		{min(sedangPre, sedangPost, sangatAktif, membantu), 60},
		// Aturan 39 moderat
		{min(sedangPre, sedangPost, sangatAktif, kurangMembantu), 60},
		// Aturan 40 moderat
		{min(sedangPre, sedangPost, aktif, sangatMembantu), 60},
		// Aturan 41 moderat
		{min(sedangPre, sedangPost, aktif, membantu), 60},
		// Aturan 42 moderat
		{min(sedangPre, sedangPost, aktif, kurangMembantu), 60},
		// Aturan 43 moderat
		{min(sedangPre, sedangPost, kurangAktif, sangatMembantu), 60},
		// Aturan 44 moderat
		{min(sedangPre, sedangPost, kurangAktif, membantu), 60},
		// Aturan 45 moderat
		{min(sedangPre, sedangPost, kurangAktif, kurangMembantu), 60},
		// Aturan 46 moderat
		{min(sedangPre, rendahPost, sangatAktif, sangatMembantu), 60},
		// Aturan 47 moderat
		{min(sedangPre, rendahPost, sangatAktif, membantu), 60},
		// Aturan 48 moderat
		{min(sedangPre, rendahPost, sangatAktif, kurangMembantu), 60},
		// Aturan 49 moderat
		{min(sedangPre, rendahPost, aktif, sangatMembantu), 60},
		// Aturan 50 moderat
		{min(sedangPre, rendahPost, aktif, membantu), 60},
		// Aturan 51 moderat
		{min(sedangPre, rendahPost, aktif, kurangMembantu), 60},
		// Aturan 52 moderat
		{min(sedangPre, rendahPost, kurangAktif, sangatMembantu), 60},
		// Aturan 53 moderat
		{min(sedangPre, rendahPost, kurangAktif, membantu), 60},
		// Aturan 54 rendah
		{min(sedangPre, rendahPost, kurangAktif, kurangMembantu), 40},
		// Aturan 55 moderat
		{min(rendahPre, tinggiPost, sangatAktif, sangatMembantu), 60},
		// Aturan 56 moderat
		{min(rendahPre, tinggiPost, sangatAktif, membantu), 60},
		// Aturan 57 moderat
		{min(rendahPre, tinggiPost, sangatAktif, kurangMembantu), 60},
		// Aturan 58 moderat
		{min(rendahPre, tinggiPost, aktif, sangatMembantu), 60},
		// Aturan 59 moderat
		{min(rendahPre, tinggiPost, aktif, membantu), 60},
		// Aturan 60 moderat
		{min(rendahPre, tinggiPost, aktif, kurangMembantu), 60},
		// Aturan 61 moderat
		{min(rendahPre, tinggiPost, kurangAktif, sangatMembantu), 60},
		// Aturan 62 moderat
		{min(rendahPre, tinggiPost, kurangAktif, membantu), 60},
		// Aturan 63 moderat
		{min(rendahPre, tinggiPost, kurangAktif, kurangMembantu), 60},
		// Aturan 64 moderat
		{min(rendahPre, sedangPost, sangatAktif, sangatMembantu), 60},
		// Aturan 65 moderat
		{min(rendahPre, sedangPost, sangatAktif, membantu), 60},
		// Aturan 66 moderat
		{min(rendahPre, sedangPost, sangatAktif, kurangMembantu), 60},
		// Aturan 67 moderat
		{min(rendahPre, sedangPost, aktif, sangatMembantu), 60},
		// Aturan 68 moderat
		{min(rendahPre, sedangPost, aktif, membantu), 60},
		// Aturan 69 moderat
		{min(rendahPre, sedangPost, aktif, kurangMembantu), 60},
		// Aturan 70 moderat
		{min(rendahPre, sedangPost, kurangAktif, sangatMembantu), 60},
		// Aturan 71 moderat
		{min(rendahPre, sedangPost, kurangAktif, membantu), 60},
		// Aturan 72 rendah
		{min(rendahPre, sedangPost, kurangAktif, kurangMembantu), 40},
		// Aturan 73 moderat
		{min(rendahPre, rendahPost, sangatAktif, sangatMembantu), 60},
		// Aturan 74 rendah
		{min(rendahPre, rendahPost, sangatAktif, membantu), 40},
		// Aturan 75 rendah
		{min(rendahPre, rendahPost, sangatAktif, kurangMembantu), 40},
		// Aturan 76 rendah
		{min(rendahPre, rendahPost, aktif, sangatMembantu), 40},
		// Aturan 77 rendah
		{min(rendahPre, rendahPost, aktif, membantu), 40},
		// Aturan 78 rendah
		{min(rendahPre, rendahPost, aktif, kurangMembantu), 40},
		// Aturan 79 rendah
		{min(rendahPre, rendahPost, kurangAktif, sangatMembantu), 40},
		// Aturan 80 rendah
		{min(rendahPre, rendahPost, kurangAktif, membantu), 40},
		// Aturan 81 rendah
		{min(rendahPre, rendahPost, kurangAktif, kurangMembantu), 40},
	}

	// Defuzzifikasi menggunakan metode centroid
	return defuzzifyCentroid(rules)
}
func min(values ...float64) float64 {
	minVal := values[0]
	for _, v := range values {
		if v < minVal {
			minVal = v
		}
	}
	return minVal
}

func MainFuzzy(preQuizScore, postQuizScore, keaktifanScore, bantuanScore int) int {
	fmt.Printf("pre quiz score : %d\n", preQuizScore)
	fmt.Printf("post quiz score : %d\n", postQuizScore)
	fmt.Printf("keaktifan score : %d\n", keaktifanScore)
	fmt.Printf("bantuan score : %d\n", bantuanScore)
	x := inferAndDefuzzify(float64(preQuizScore), float64(postQuizScore), float64(keaktifanScore), float64(bantuanScore))
	fmt.Printf("Hasil Kontribusi: %.2f\n", x)
	y, z, i := hasilKontribusi(x)
	fmt.Printf("Rendah: %.2f\n", y)
	fmt.Printf("Moderat: %.2f\n", z)
	fmt.Printf("Signifikan: %.2f\n", i)
	return int(x)
}
