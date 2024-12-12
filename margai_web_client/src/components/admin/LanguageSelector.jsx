import { Globe } from "lucide-react";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuRadioGroup,
  DropdownMenuRadioItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import i18n from "i18next";
import { useState } from "react";

const languages = [
  { code: "en", label: "English" },
  { code: "fr", label: "French" },
  { code: "gu", label: "Gujarati" },
  { code: "hi", label: "Hindi" },
  { code: "mr", label: "Marathi" },
  { code: "ta", label: "Tamil" },
];

function LanguageSelector() {
  const [selectedLanguage, setSelectedLanguage] = useState(i18n.language);

  const handleChangeLanguage = (lan) => {
    setSelectedLanguage(lan);
    i18n.changeLanguage(lan);
  };

  return (
    <DropdownMenu>
      <DropdownMenuTrigger asChild>
        <button className="rounded-full border-none bg-[#FFF] p-2 text-white shadow-sm hover:bg-gray-50">
          <Globe size={24} style={{ color: "#018183" }} />
        </button>
      </DropdownMenuTrigger>
      <DropdownMenuContent align="center" className="w-48">
        <DropdownMenuRadioGroup
          value={selectedLanguage}
          onValueChange={handleChangeLanguage}
        >
          {languages.map((language) => (
            <DropdownMenuRadioItem
              key={language.code}
              className="cursor-pointer text-[#018183]"
              value={language.code}
            >
              {language.label}
            </DropdownMenuRadioItem>
          ))}
        </DropdownMenuRadioGroup>
      </DropdownMenuContent>
    </DropdownMenu>
  );
}

export default LanguageSelector;
