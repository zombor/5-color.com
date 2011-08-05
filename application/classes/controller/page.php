<?php
/**
 * Controller for the CMS pages
 *
 * @package    5-Color
 * @author     Jeremy Bush
 * @copyright  (c) 2010 Jeremy Bush
 */
class Controller_Page extends Controller
{
	/**
	 * Base action for displaying pages
	 *
	 * @return null
	 */
	public function action_index()
	{
		$page = $this->request->param('page');

		$klass = 'View_Page_'.$page;

		if (class_exists($klass))
		{
			$body = (string) new $klass;
			$body.=View::factory('profiler/stats');
			$this->response->body(new $klass);
		}
		else
		{
			throw new HTTP_Exception_404('Page Not Found!');
		}
	}
}