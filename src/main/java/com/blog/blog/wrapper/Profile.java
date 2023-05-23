package com.blog.blog.wrapper;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "projile", value = "/profile")
public class Profile extends HttpServlet {
    // took from here + chat gpt
    // https://namesfrog.com/title-names/
    String[] postfixes = {
            "Master of Spies",
            "Cardinal of Sanctity",
            "Wisdom Chancellor",
            "Starwielder",
            "Director of Merchants",
            "Lady of Finance",
            "Silent Sentinel",
            "Eternity's Harbinger",
            "Grand Master of Purity",
            "Virtuous Duke",
            "Protector of Swords",
            "Solitude's Sovereign",
            "Elder of the Winds",
            "Potential Prodigy",
            "Delegate of Water",
            "Courage Cardinal",
            "Head of Forestry",
            "Witch of Mercy",
            "Imam of Healing",
            "Exarch of Finance",
            "Governor of Emissaries",
            "Baron of Emissaries",
            "Excellence Exemplar",
            "Mercy's Matron",
            "Deacon of the Phoenix",
            "Queen of the Skies",
            "Resilience's Regent",
            "Strength Guardian",
            "Count of the Sun",
            "Bishop of Peace",
            "Duality Duchess",
            "Truth Warden",
            "Chancellor of the Flame",
            "Herald of Watch",
            "Persistence Prelate",
            "Prosperity Tyrant",
            "Matriarch of Commerce",
            "Elevation Empress",
            "Balance's Bishop",
            "Preacher of the White",
            "Ocean Overlord",
            "Apostle of Blood",
            "Constellation Count",
            "Commander of Blue",
            "Wind Warlord",
            "Defender of Life",
            "Grit Guardian",
            "Lady of Death",
            "Artistry Arbiter",
            "Sir of Culture",
            "Shadow Scribe",
            "Priestess of the Veil",
            "Elemental Empress",
            "Templar of Pure Hearts",
            "Knowledge Knight"
    };

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("postfix", postfixes[(int) (Math.random() * postfixes.length)]);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/pages/user/profile.jsp");
        requestDispatcher.forward(req, resp);
    }
}
