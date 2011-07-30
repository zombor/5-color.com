<?php
/**
 * View class for the B&R page
 *
 * @package    5-color.com
 * @author     Jeremy Bush
 * @copyright  (c) 2011 Jeremy Bush
 */
class View_Page_Banned extends Kostache_Layout
{
	protected $_banned = array(
		'Battle of Wits',
		'Bringer Of The Black Dawn',
		'Darkpact',
		'Holistic Wisdom',
		'Insidious Dreams',
		'Parallel Thoughts',
		'Phyrexian Portal',
		'Shahrazad',
		'Sundering Titan',
	);

	protected $_restricted = array(
		'Academy Rector',
		'All Sun\'s Dawn',
		'Ancestral Recall',
		'Balance',
		'Black Lotus',
		'Chaos Orb',
		'Crop Rotation',
		'Crucible of Worlds',
		'Demonic Consultation',
		'Demonic Tutor',
		'Divining Witch',
		'Enlightened Tutor',
		'Eternal Witness',
		'Fabricate',
		'Fastbond',
		'Gamble',
		'Gifts Ungiven',
		'Grim Tutor',
		'Hermit Druid',
		'Imperial Seal',
		'Intuition',
		'Isochron Scepter',
		'Library of Alexandria',
		'Mana Crypt',
		'Mana Vault',
		'Merchant Scroll',
		'Mox Crystal',
		'Mox Emerald',
		'Mox Jet',
		'Mox Pearl',
		'Mox Ruby',
		'Mox Sapphire',
		'Mystical Tutor',
		'Nostalgic Dreams',
 		'Oath of Druids',
		'Panoptic Mirror',
		'Personal Tutor',
		'Regrowth',
		'Sol Ring',
		'Strip Mine',
		'Survival of the Fittest',
		'Sylvan Scrying',
		'Time Spiral',
		'Timetwister',
		'Time Vault',
		'Time Walk',
		'Tinker',
		'Tolarian Academy',
		'Transmute Artifact',
		'Vampiric Tutor',
		'Wheel of Fortune',
		'Yawgmoth\'s Bargain',
		'Yawgmoth\'s Will',
	);

	/**
	 * Gets all banned cards
	 *
	 * @return array
	 */
	public function banned()
	{
		return $this->_process_cards($this->_banned);
	}

	/**
	 * Gets all restricted cards
	 *
	 * @return array
	 */
	public function restricted()
	{
		return $this->_process_cards($this->_restricted);
	}

	/**
	 * Returns the date this B&R list applies for
	 *
	 * @return array
	 */
	public function date()
	{
		return array(
			'year' => date('Y'),
			'month' => date('m'),
		);
	}

	/**
	 * Processes an array of cards to format for a table
	 *
	 * @return array
	 */
	protected function _process_cards(array $cards)
	{
		sort($cards);

		$processed_cards = array();

		$count = 0;
		$row = array();
		foreach ($cards as $processed)
		{
			if ($count == 0)
			{
				$row = array();
			}

			$row[] = array('name' => $processed);

			$count++;

			if ($count == 4)
			{
				$processed_cards[] = array('row' => $row);
				$count = 0;
			}
		}

		return $processed_cards;
	}
}