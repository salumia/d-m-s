<?php

namespace Modules\Page\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Venturecraft\Revisionable\RevisionableTrait;

use Modules\Page\Entities\PageFiles as PageFiles;

class Page extends Model
{
    use SoftDeletes;
    use RevisionableTrait;
    protected $fillable = [
		'id',
		'title',
		'type',
		'redirect_url',
		'description',
		'cover_image'
	];
	
	public function getFiles() {
        return $this->hasMany(PageFiles::class,'page_id');
    }
}